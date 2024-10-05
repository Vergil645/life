#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

using namespace llvm;

struct ModPass : public PassInfoMixin<ModPass> {
    PreservedAnalyses run(Module& M, ModuleAnalysisManager& AM) {
        for (auto& F : M) {
            // Modify only app function
            if (F.isDeclaration() || F.getName() != "app")
                continue;

            // Prepare builder for IR modification
            LLVMContext& Ctx = F.getContext();
            IRBuilder<> builder(Ctx);

            // Prepare useLogger function
            Type* useLogRetType = builder.getVoidTy();
            ArrayRef<Type*> useLogParamTypes = {
                builder.getInt8Ty()->getPointerTo(),
                builder.getInt8Ty()->getPointerTo(),
            };
            FunctionType* useLogFuncType = FunctionType::get(useLogRetType, useLogParamTypes, false);
            FunctionCallee useLogFunc = M.getOrInsertFunction("useLogger", useLogFuncType);

            for (auto& B : F) {
                for (auto& I : B) {
                    if (this->isMustBeSkipped(&I))
                        continue;

                    Value* instructionName = builder.CreateGlobalStringPtr(I.getOpcodeName(), "", 0, &M);

                    for (auto& U : I.uses()) {
                        User* user = U.getUser();

                        if (auto* userInstruction = dyn_cast<Instruction>(user)) {
                            if (this->isMustBeSkipped(userInstruction))
                                continue;

                            Value* userName =
                                builder.CreateGlobalStringPtr(userInstruction->getOpcodeName(), "", 0, &M);
                            ArrayRef<Value*> args = {instructionName, userName};

                            // Insert a call to useLogger function
                            builder.SetInsertPoint(&I);
                            builder.CreateCall(useLogFunc, args);
                        }
                    }
                }
            }
        }

        return PreservedAnalyses::none();
    };

   private:
    bool isMustBeSkipped(Instruction const* I) {
        // Skip ret instructions
        if (auto* ret = dyn_cast<ReturnInst>(I))
            return true;

        // Skip phi instructions
        if (auto* phi = dyn_cast<PHINode>(I))
            return true;

        return false;
    }
};

PassPluginLibraryInfo getPassPluginInfo() {
    const auto callback = [](PassBuilder& PB) {
        PB.registerOptimizerLastEPCallback([&](ModulePassManager& MPM, auto) { MPM.addPass(ModPass{}); });
    };

    return {LLVM_PLUGIN_API_VERSION, "Pass", "0.0.1", callback};
};

/* When a plugin is loaded by the driver, it will call this entry point to
obtain information about this plugin and about how to register its passes.
*/
extern "C" LLVM_ATTRIBUTE_WEAK PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return getPassPluginInfo();
}
