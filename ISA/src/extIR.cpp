#include "extIR.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

void ExtIR::buildIR(Binary &Bin) {
  module = new Module("top", context);
  IRBuilder<> builder(context);
  Type *voidType = Type::getVoidTy(context);
  Type *int64Type = Type::getInt64Ty(context);
  Type *int8Type = Type::getInt8Ty(context);

  //[16 x i64] regFile = {0, 0, 0, 0}
  ArrayType *regFileType = ArrayType::get(int64Type, CPU::RegSize);
  module->getOrInsertGlobal("regFile", regFileType);
  regFile = module->getNamedGlobal("regFile");

  // declare void @main()
  FunctionType *funcType = FunctionType::get(voidType, false);
  mainFunc =
      Function::Create(funcType, Function::ExternalLinkage, "main", module);
  // Funcions types
  FunctionType *voidFuncType = FunctionType::get(voidType, false);
  ArrayRef<Type *> int64x3Types = {int64Type, int64Type, int64Type};
  FunctionType *int64x3FuncType =
      FunctionType::get(voidType, int64x3Types, false);

  // Functions
#define _ISA(_Opcode, _Name, _SkipArgs, _ReadArgs, _WriteArgs, _Execute,       \
             _IRGenExecute)                                                    \
  FunctionCallee Callee##_Name =                                               \
      module->getOrInsertFunction("do_" #_Name, int64x3FuncType);
#include "ISA.h"
#undef _ISA

  std::unordered_map<uint64_t, BasicBlock *> BBMap;
  for (auto &BB : Bin.BBName2PC) {
    BBMap[BB.second] = BasicBlock::Create(context, BB.first, mainFunc);
  }

  uint64_t PC = 0;
  builder.SetInsertPoint(BBMap[0]);
  for (Instr &I : Bin.Instrs) {
    Value *arg1 = builder.getInt64(I.R1);
    Value *arg2 = builder.getInt64(I.R2);
    Value *arg3 = builder.getInt64(I.R3Imm);
    Value *args[] = {arg1, arg2, arg3};
    switch (I.Op) {
    default:
      break;
#define _ISA(_Opcode, _Name, _SkipArgs, _ReadArgs, _WriteArgs, _Execute,       \
             _IRGenExecute)                                                    \
  case (_Opcode):                                                              \
    builder.CreateCall(Callee##_Name, args);                                   \
    break;
#include "ISA.h"
#undef _ISA
    }
    PC++;
    if (I.Op == Instr::BR_COND) {
      Value *reg_p = builder.CreateConstGEP2_64(regFileType, regFile, 0, I.R1);
      Value *reg_i1 = builder.CreateTrunc(builder.CreateLoad(int64Type, reg_p),
                                          builder.getInt1Ty());
      builder.CreateCondBr(reg_i1, BBMap[I.R3Imm], BBMap[PC]);
      builder.SetInsertPoint(BBMap[PC]);
      continue;
    }
    auto BB = BBMap.find(PC);
    if (I.Op == Instr::EXIT) {
      builder.CreateRetVoid();
      if (BB != BBMap.end())
        builder.SetInsertPoint(BB->second);
      continue;
    }
    if (BB != BBMap.end()) {
      builder.CreateBr(BB->second);
      builder.SetInsertPoint(BB->second);
    }
  }
}

void ExtIR::dumpIR() {
  outs() << "\n[LLVM IR]:\n";
  module->print(outs(), nullptr);
  outs() << "\n";
}
bool ExtIR::verifyIR() {
  bool verif = verifyFunction(*mainFunc, &outs());
  outs() << "[VERIFICATION] " << (!verif ? "OK\n\n" : "FAIL\n\n");
  return verif;
}

void ExtIR::executeIR(CPU &Cpu) {
  InitializeNativeTarget();
  InitializeNativeTargetAsmPrinter();

  ExecutionEngine *ee = EngineBuilder(std::unique_ptr<Module>(module)).create();
  ee->InstallLazyFunctionCreator([=](const std::string &fnName) -> void * {
#define _ISA(_Opcode, _Name, _SkipArgs, _ReadArgs, _WriteArgs, _Execute,       \
             _IRGenExecute)                                                    \
  if (fnName == "do_" #_Name)                                                  \
    return reinterpret_cast<void *>(CPU::do_##_Name);
#include "ISA.h"
#undef _ISA
    return nullptr;
  });

  ee->addGlobalMapping(regFile, (void *)Cpu.RegFile);
  ee->finalizeObject();

  simInit();
  CPU::setCPU(&Cpu);
  // Cpu.DumpInstrs = true;

  ArrayRef<GenericValue> noargs;
  outs() << "\n#[Running code]\n";
  ee->runFunction(mainFunc, noargs);
  outs() << "#[Code was run]\n";

  simExit();
}