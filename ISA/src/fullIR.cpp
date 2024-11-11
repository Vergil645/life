#include "fullIR.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

void FullIR::buildIR(Binary &Bin) {
  module = new Module("top", context);
  IRBuilder<> builder(context);
  Type *voidType = Type::getVoidTy(context);
  Type *int32Type = Type::getInt32Ty(context);
  Type *int64Type = Type::getInt64Ty(context);
  Type *int8Type = Type::getInt8Ty(context);

  //[16 x i64] regFile = {0, 0, 0, 0}
  ArrayType *regFileType = ArrayType::get(int64Type, CPU::RegSize);

  GlobalVariable *regFile = new GlobalVariable(
      *module, regFileType, false, GlobalValue::PrivateLinkage, 0, "regFile");
  regFile->setInitializer(ConstantAggregateZero::get(regFileType));

  // declare void @main()
  FunctionType *funcType = FunctionType::get(voidType, false);
  mainFunc =
      Function::Create(funcType, Function::ExternalLinkage, "main", module);
  // Funcions types
  FunctionType *voidFuncType = FunctionType::get(voidType, false);
  ArrayRef<Type *> int32x3Types = {int32Type, int32Type, int32Type};
  FunctionType *int32x3FuncType =
      FunctionType::get(voidType, int32x3Types, false);

  // declare i32 @simRand(...) local_unnamed_addr #3
  FunctionType* simRandFuncType = FunctionType::get(builder.getInt32Ty(), false);
  FunctionCallee simRandFunc = module->getOrInsertFunction("simRand", simRandFuncType);

  // declare void @simPutPixel(i32 noundef, i32 noundef, i32 noundef)
  FunctionCallee simPutPixelFunc =
      module->getOrInsertFunction("simPutPixel", int32x3FuncType);

  // declare void @simFlush()
  FunctionType *simFlushType = FunctionType::get(voidType, false);
  FunctionCallee simFlushFunc =
      module->getOrInsertFunction("simFlush", simFlushType);

  // declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2
  ArrayRef<Type*> memsetParamTypes = {
      builder.getPtrTy(),
      builder.getInt8Ty(),
      builder.getInt64Ty(),
      builder.getInt1Ty(),
  };
  FunctionType* memsetFuncType = FunctionType::get(builder.getVoidTy(), memsetParamTypes, false);
  FunctionCallee memsetFunc = module->getOrInsertFunction("llvm.memset.p0.i64", memsetFuncType);

  // declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #4
  ArrayRef<Type*> memcpyParamTypes = {
      builder.getPtrTy(),
      builder.getPtrTy(),
      builder.getInt64Ty(),
      builder.getInt1Ty(),
  };
  FunctionType* memcpyFuncType =
      FunctionType::get(builder.getVoidTy(), memcpyParamTypes, false);
  FunctionCallee memcpyFunc =
      module->getOrInsertFunction("llvm.memcpy.p0.p0.i64", memcpyFuncType);


  std::unordered_map<uint64_t, BasicBlock *> BBMap;
  for (auto &BB : Bin.BBName2PC) {
    BBMap[BB.second] = BasicBlock::Create(context, BB.first, mainFunc);
  }

  uint64_t PC = 0;
  builder.SetInsertPoint(BBMap[0]);
  for (Instr &I : Bin.Instrs) {
    switch (I.Op) {
    default:
      break;
#define _ISA(_Opcode, _Name, _SkipArgs, _ReadArgs, _WriteArgs, _Execute,       \
             _IRGenExecute)                                                    \
  case (_Opcode):                                                              \
    _IRGenExecute;                                                             \
    break;
#include "ISA.h"
#undef _ISA
    }
    PC++;
    auto BB = BBMap.find(PC);
    if (BB != BBMap.end()) {
      builder.CreateBr(BB->second);
      builder.SetInsertPoint(BB->second);
    }
  }
}

void FullIR::executeIR(CPU &Cpu) {
  InitializeNativeTarget();
  InitializeNativeTargetAsmPrinter();

  ExecutionEngine *ee = EngineBuilder(std::unique_ptr<Module>(module)).create();
  ee->InstallLazyFunctionCreator([=](const std::string &fnName) -> void * {
    if (fnName == "simRand") {
      return reinterpret_cast<void*>(simRand);
    }
    if (fnName == "simFlush") {
      return reinterpret_cast<void *>(simFlush);
    }
    if (fnName == "simPutPixel") {
      return reinterpret_cast<void *>(simPutPixel);
    }
    return nullptr;
  });
  ee->finalizeObject();

  simInit();
  CPU::setCPU(&Cpu);
  Cpu.DumpInstrs = true;

  ArrayRef<GenericValue> noargs;
  outs() << "\n#[Running code]\n";
  ee->runFunction(mainFunc, noargs);
  outs() << "#[Code was run]\n";

  simExit();
}