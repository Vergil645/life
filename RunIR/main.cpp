#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/TargetSelect.h"

extern "C" {
#include "sim.h"
}

using namespace llvm;

int main(int argc, char* argv[]) {
    if (argc < 2) {
        errs() << "Expected an argument - IR file name\n";
        exit(1);
    }

    LLVMContext context;
    SMDiagnostic Err;
    std::unique_ptr<Module> module = parseIRFile(argv[1], Err, context);

    if (module == nullptr) {
        Err.print(argv[0], errs());
        return 1;
    }

    Function* mainFunc = module->getFunction("main");
    if (mainFunc == nullptr) {
        outs() << "No 'main' function\n";
        return 0;
    }

    // ===== INTERPRETER =====

    // Dump LLVM IR
    module->print(outs(), nullptr);

    // LLVM IR Interpreter
    outs() << "[EE] Run\n";
    InitializeNativeTarget();
    InitializeNativeTargetAsmPrinter();

    ExecutionEngine* ee = EngineBuilder(std::move(module)).create();
    ee->InstallLazyFunctionCreator([&](const std::string& fnName) -> void* {
        if (fnName == "simFlush") {
            return reinterpret_cast<void*>(simFlush);
        }
        if (fnName == "simPutPixel") {
            return reinterpret_cast<void*>(simPutPixel);
        }
        if (fnName == "simRand") {
            return reinterpret_cast<void*>(simRand);
        }
        return nullptr;
    });
    ee->finalizeObject();

    simInit();

    ArrayRef<GenericValue> noargs;
    outs() << "[EE] Running code\n";
    ee->runFunction(mainFunc, noargs);
    outs() << "[EE] Code was run\n";

    simExit();

    return EXIT_SUCCESS;
}