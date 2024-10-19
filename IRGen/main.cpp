#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/TargetSelect.h"

extern "C" {
#include "sim.h"
}

using namespace llvm;

int main(void) {
    LLVMContext context;
    // ; ModuleID = 'app'
    // source_filename = "app"
    Module* module = new Module("app", context);
    IRBuilder<> builder(context);

    // ===== DECLARATIONS =====

    // ; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
    // declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2
    ArrayRef<Type*> llvmMemsetP0I64ParamTypes = {
        builder.getPtrTy(),
        builder.getInt8Ty(),
        builder.getInt64Ty(),
        builder.getInt1Ty(),
    };
    FunctionType* llvmMemsetP0I64FuncType = FunctionType::get(builder.getVoidTy(), llvmMemsetP0I64ParamTypes, false);
    FunctionCallee llvmMemsetP0I64Func = module->getOrInsertFunction("llvm.memset.p0.i64", llvmMemsetP0I64FuncType);

    // declare i32 @simRand(...) local_unnamed_addr #3
    FunctionType* simRandFuncType = FunctionType::get(builder.getInt32Ty(), false);
    FunctionCallee simRandFunc = module->getOrInsertFunction("simRand", simRandFuncType);

    // declare void @simPutPixel(i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #3
    ArrayRef<Type*> simPutPixelParamTypes = {
        builder.getInt32Ty(),
        builder.getInt32Ty(),
        builder.getInt32Ty(),
    };
    FunctionType* simPutPixelFuncType = FunctionType::get(builder.getVoidTy(), simPutPixelParamTypes, false);
    FunctionCallee simPutPixelFunc = module->getOrInsertFunction("simPutPixel", simPutPixelFuncType);

    // declare void @simFlush(...) local_unnamed_addr #3
    FunctionType* simFlushFuncType = FunctionType::get(builder.getVoidTy(), false);
    FunctionCallee simFlushFunc = module->getOrInsertFunction("simFlush", simFlushFuncType);

    // ; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
    // declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #4
    ArrayRef<Type*> llvmMemcpyP0P0I64ParamTypes = {
        builder.getPtrTy(),
        builder.getPtrTy(),
        builder.getInt64Ty(),
        builder.getInt1Ty(),
    };
    FunctionType* llvmMemcpyP0P0I64FuncType =
        FunctionType::get(builder.getVoidTy(), llvmMemcpyP0P0I64ParamTypes, false);
    FunctionCallee llvmMemcpyP0P0I64Func =
        module->getOrInsertFunction("llvm.memcpy.p0.p0.i64", llvmMemcpyP0P0I64FuncType);

    // ===== FUNCTION: app() =====

    // ; Function Attrs: nounwind uwtable
    // define dso_local void @app() local_unnamed_addr #0 {
    FunctionType* appFuncType = FunctionType::get(builder.getVoidTy(), false);
    Function* appFunc = Function::Create(appFuncType, Function::ExternalLinkage, "app", module);

    // BasicBlocks:
    BasicBlock* BB0 = BasicBlock::Create(context, "", appFunc);
    BasicBlock* BB3 = BasicBlock::Create(context, "", appFunc);
    BasicBlock* BB6 = BasicBlock::Create(context, "", appFunc);
    BasicBlock* BB9 = BasicBlock::Create(context, "", appFunc);
    BasicBlock* BB19 = BasicBlock::Create(context, "", appFunc);
    BasicBlock* BB21 = BasicBlock::Create(context, "", appFunc);
    BasicBlock* BB22 = BasicBlock::Create(context, "", appFunc);
    BasicBlock* BB27 = BasicBlock::Create(context, "", appFunc);
    BasicBlock* BB64 = BasicBlock::Create(context, "", appFunc);
    BasicBlock* BB67 = BasicBlock::Create(context, "", appFunc);

    // 0:
    builder.SetInsertPoint(BB0);
    // %1 = alloca [132612 x i32], align 16
    AllocaInst* val1 = builder.CreateAlloca(ArrayType::get(builder.getInt32Ty(), 132612));
    // %2 = alloca [132612 x i32], align 16
    AllocaInst* val2 = builder.CreateAlloca(ArrayType::get(builder.getInt32Ty(), 132612));
    // call void @llvm.lifetime.start.p0(i64 530448, ptr nonnull %1) #5
    // nope
    // call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(530448) %1, i8 0, i64 530448, i1 false)
    {
        ArrayRef<Value*> Args = {
            val1,
            builder.getInt8(0),
            builder.getInt64(530448),
            builder.getInt1(false),
        };
        builder.CreateCall(llvmMemsetP0I64Func, Args);
    }
    // call void @llvm.lifetime.start.p0(i64 530448, ptr nonnull %2) #5
    // nope
    // call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(530448) %2, i8 0, i64 530448, i1 false)
    {
        ArrayRef<Value*> Args = {
            val2,
            builder.getInt8(0),
            builder.getInt64(530448),
            builder.getInt1(false),
        };
        builder.CreateCall(llvmMemsetP0I64Func, Args);
    }
    // br label %3
    builder.CreateBr(BB3);

    // 3:                                                ; preds = %0, %6
    builder.SetInsertPoint(BB3);
    // %4 = phi i64 [ 1, %0 ], [ %7, %6 ]
    PHINode* val4 = builder.CreatePHI(builder.getInt64Ty(), 2);
    // %5 = mul nuw nsw i64 %4, 514
    Value* val5 = builder.CreateMul(val4, builder.getInt64(514), "", true, true);
    // br label %9
    builder.CreateBr(BB9);

    // 6:                                                ; preds = %9
    builder.SetInsertPoint(BB6);
    // %7 = add nuw nsw i64 %4, 1
    Value* val7 = builder.CreateAdd(val4, builder.getInt64(1), "", true, true);
    // %8 = icmp eq i64 %7, 257
    Value* val8 = builder.CreateICmpEQ(val7, builder.getInt64(257));
    // br i1 %8, label %19, label %3, !llvm.loop !5
    builder.CreateCondBr(val8, BB19, BB3);

    // 9:                                                ; preds = %3, %9
    builder.SetInsertPoint(BB9);
    // %10 = phi i64 [ 1, %3 ], [ %17, %9 ]
    PHINode* val10 = builder.CreatePHI(builder.getInt64Ty(), 2);
    // %11 = tail call i32 (...) @simRand() #5
    CallInst* val11 = builder.CreateCall(simRandFunc);
    val11->setTailCall(true);
    // %12 = srem i32 %11, 5
    Value* val12 = builder.CreateSRem(val11, builder.getInt32(5));
    // %13 = icmp eq i32 %12, 0
    Value* val13 = builder.CreateICmpEQ(val12, builder.getInt32(0));
    // %14 = add nuw nsw i64 %10, %5
    Value* val14 = builder.CreateAdd(val10, val5, "", true, true);
    // %15 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i64 %14
    Value* val15 = builder.CreateInBoundsGEP(ArrayType::get(builder.getInt32Ty(), 132612), val1, {builder.getInt64(0), val14});
    // %16 = zext i1 %13 to i32
    Value* val16 = builder.CreateZExt(val13, builder.getInt32Ty());
    // store i32 %16, ptr %15, align 4, !tbaa !7
    builder.CreateAlignedStore(val16, val15, {Align(4)});
    // %17 = add nuw nsw i64 %10, 1
    Value* val17 = builder.CreateAdd(val10, builder.getInt64(1), "", true, true);
    // %18 = icmp eq i64 %17, 513
    Value* val18 = builder.CreateICmpEQ(val17, builder.getInt64(513));
    // br i1 %18, label %6, label %9, !llvm.loop !11
    builder.CreateCondBr(val18, BB6, BB9);

    // 19:                                               ; preds = %6, %67
    builder.SetInsertPoint(BB19);
    // %20 = phi i32 [ %68, %67 ], [ 0, %6 ]
    PHINode* val20 = builder.CreatePHI(builder.getInt32Ty(), 2);
    // br label %22
    builder.CreateBr(BB22);

    // 21:                                               ; preds = %67
    builder.SetInsertPoint(BB21);
    // call void @llvm.lifetime.end.p0(i64 530448, ptr nonnull %2) #5
    // nope
    // call void @llvm.lifetime.end.p0(i64 530448, ptr nonnull %1) #5
    // nope
    // ret void
    builder.CreateRetVoid();

    // 22:                                               ; preds = %19, %64
    builder.SetInsertPoint(BB22);
    // %23 = phi i64 [ 514, %19 ], [ %65, %64 ]
    PHINode* val23 = builder.CreatePHI(builder.getInt64Ty(), 2);
    // %24 = trunc i64 %23 to i32
    Value* val24 = builder.CreateTrunc(val23, builder.getInt32Ty());
    // %25 = urem i32 %24, 514
    Value* val25 = builder.CreateURem(val24, builder.getInt32(514));
    // %26 = udiv i32 %24, 514
    Value* val26 = builder.CreateUDiv(val24, builder.getInt32(514));
    // switch i32 %25, label %27 [
    //   i32 513, label %64
    //   i32 0, label %64
    // ]
    {
        SwitchInst* switchInst = builder.CreateSwitch(val25, BB27, 2);
        switchInst->addCase(builder.getInt32(513), BB64);
        switchInst->addCase(builder.getInt32(0), BB64);
    }

    // 27:                                               ; preds = %22
    builder.SetInsertPoint(BB27);
    // %28 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i64 %23
    Value* val28 = builder.CreateInBoundsGEP(ArrayType::get(builder.getInt32Ty(), 132612), val1, {builder.getInt64(0), val23});
    // %29 = add nsw i32 %25, -1
    Value* val29 = builder.CreateAdd(val25, builder.getInt32(-1), "", false, true);
    // %30 = add nsw i32 %26, -1
    Value* val30 = builder.CreateAdd(val26, builder.getInt32(-1), "", false, true);
    // %31 = load i32, ptr %28, align 4, !tbaa !7
    LoadInst* val31 = builder.CreateAlignedLoad(builder.getInt32Ty(), val28, {Align{4}});
    // %32 = mul nsw i32 %31, 16777215
    Value* val32 = builder.CreateMul(val31, builder.getInt32(16777215), "", false, true);
    // %33 = add i32 %32, -16777216
    Value* val33 = builder.CreateAdd(val32, builder.getInt32(static_cast<uint32_t>(-16777216)));
    // tail call void @simPutPixel(i32 noundef %29, i32 noundef %30, i32 noundef %33) #5
    {
        CallInst* callInst = builder.CreateCall(simPutPixelFunc, {val29, val30, val33});
        callInst->setTailCall(true);
    }
    // %34 = getelementptr inbounds i32, ptr %28, i64 -514
    Value* val34 = builder.CreateInBoundsGEP(builder.getInt32Ty(), val28, {builder.getInt64(static_cast<uint64_t>(-514))});
    // %35 = getelementptr inbounds i32, ptr %28, i64 -515
    Value* val35 = builder.CreateInBoundsGEP(builder.getInt32Ty(), val28, {builder.getInt64(static_cast<uint64_t>(-515))});
    // %36 = load i32, ptr %35, align 4, !tbaa !7
    LoadInst* val36 = builder.CreateAlignedLoad(builder.getInt32Ty(), val35, {Align{4}});
    // %37 = load i32, ptr %34, align 4, !tbaa !7
    LoadInst* val37 = builder.CreateAlignedLoad(builder.getInt32Ty(), val34, {Align{4}});
    // %38 = add nsw i32 %37, %36
    Value* val38 = builder.CreateAdd(val37, val36, "", false, true);
    // %39 = getelementptr inbounds i32, ptr %28, i64 -513
    Value* val39 = builder.CreateInBoundsGEP(builder.getInt32Ty(), val28, {builder.getInt64(static_cast<uint64_t>(-513))});
    // %40 = load i32, ptr %39, align 4, !tbaa !7
    LoadInst* val40 = builder.CreateAlignedLoad(builder.getInt32Ty(), val39, {Align{4}});
    // %41 = add nsw i32 %38, %40
    Value* val41 = builder.CreateAdd(val38, val40, "", false, true);
    // %42 = getelementptr inbounds i32, ptr %28, i64 -1
    Value* val42 = builder.CreateInBoundsGEP(builder.getInt32Ty(), val28, {builder.getInt64(static_cast<uint64_t>(-1))});
    // %43 = load i32, ptr %42, align 4, !tbaa !7
    LoadInst* val43 = builder.CreateAlignedLoad(builder.getInt32Ty(), val42, {Align{4}});
    // %44 = add nsw i32 %41, %43
    Value* val44 = builder.CreateAdd(val41, val43, "", false, true);
    // %45 = getelementptr inbounds i32, ptr %28, i64 1
    Value* val45 = builder.CreateInBoundsGEP(builder.getInt32Ty(), val28, {builder.getInt64(1)});
    // %46 = load i32, ptr %45, align 4, !tbaa !7
    LoadInst* val46 = builder.CreateAlignedLoad(builder.getInt32Ty(), val45, {Align{4}});
    // %47 = add nsw i32 %44, %46
    Value* val47 = builder.CreateAdd(val44, val46, "", false, true);
    // %48 = getelementptr inbounds i32, ptr %28, i64 514
    Value* val48 = builder.CreateInBoundsGEP(builder.getInt32Ty(), val28, {builder.getInt64(514)});
    // %49 = getelementptr inbounds i32, ptr %28, i64 513
    Value* val49 = builder.CreateInBoundsGEP(builder.getInt32Ty(), val28, {builder.getInt64(513)});
    // %50 = load i32, ptr %49, align 4, !tbaa !7
    LoadInst* val50 = builder.CreateAlignedLoad(builder.getInt32Ty(), val49, {Align{4}});
    // %51 = add nsw i32 %47, %50
    Value* val51 = builder.CreateAdd(val47, val50, "", false, true);
    // %52 = load i32, ptr %48, align 4, !tbaa !7
    LoadInst* val52 = builder.CreateAlignedLoad(builder.getInt32Ty(), val48, {Align{4}});
    // %53 = add nsw i32 %51, %52
    Value* val53 = builder.CreateAdd(val51, val52, "", false, true);
    // %54 = getelementptr inbounds i32, ptr %28, i64 515
    Value* val54 = builder.CreateInBoundsGEP(builder.getInt32Ty(), val28, {builder.getInt64(515)});
    // %55 = load i32, ptr %54, align 4, !tbaa !7
    LoadInst* val55 = builder.CreateAlignedLoad(builder.getInt32Ty(), val54, {Align{4}});
    // %56 = add nsw i32 %53, %55
    Value* val56 = builder.CreateAdd(val53, val55, "", false, true);
    // %57 = getelementptr inbounds [132612 x i32], ptr %2, i64 0, i64 %23
    Value* val57 = builder.CreateInBoundsGEP(ArrayType::get(builder.getInt32Ty(), 132612), val2, {builder.getInt64(0), val23});
    // %58 = icmp eq i32 %56, 3
    Value* val58 = builder.CreateICmpEQ(val56, builder.getInt32(3));
    // %59 = icmp ne i32 %31, 0
    Value* val59 = builder.CreateICmpNE(val31, builder.getInt32(0));
    // %60 = icmp eq i32 %56, 2
    Value* val60 = builder.CreateICmpEQ(val56, builder.getInt32(2));
    // %61 = and i1 %59, %60
    Value* val61 = builder.CreateAnd(val59, val60);
    // %62 = or i1 %58, %61
    Value* val62 = builder.CreateOr(val58, val61);
    // %63 = zext i1 %62 to i32
    Value* val63 = builder.CreateZExt(val62, builder.getInt32Ty());
    // store i32 %63, ptr %57, align 4, !tbaa !7
    builder.CreateAlignedStore(val63, val57, {Align{4}});
    // br label %64
    builder.CreateBr(BB64);

    // 64:                                               ; preds = %22, %22, %27
    builder.SetInsertPoint(BB64);
    // %65 = add nuw nsw i64 %23, 1
    Value* val65 = builder.CreateAdd(val23, builder.getInt64(1), "", true, true);
    // %66 = icmp eq i64 %65, 132098
    Value* val66 = builder.CreateICmpEQ(val65, builder.getInt64(132098));
    // br i1 %66, label %67, label %22, !llvm.loop !12
    builder.CreateCondBr(val66, BB67, BB22);

    // 67:                                               ; preds = %64
    builder.SetInsertPoint(BB67);
    // call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(530448) %1, ptr noundef nonnull align 16 dereferenceable(530448) %2, i64 530448, i1 false), !tbaa !7
    builder.CreateCall(llvmMemcpyP0P0I64Func, {val1, val2, builder.getInt64(530448), builder.getInt1(false)});
    // tail call void (...) @simFlush() #5
    {
        CallInst* callInst = builder.CreateCall(simFlushFunc);
        callInst->setTailCall(true);
    }
    // %68 = add nuw nsw i32 %20, 1
    Value* val68 = builder.CreateAdd(val20, builder.getInt32(1), "", true, true);
    // %69 = icmp eq i32 %68, 1000
    Value* val69 = builder.CreateICmpEQ(val68, builder.getInt32(1000));
    // br i1 %69, label %21, label %19, !llvm.loop !13
    builder.CreateCondBr(val69, BB21, BB19);

    // }

    // Link PHI nodes
    // %4 = phi i64 [ 1, %0 ], [ %7, %6 ]
    val4->addIncoming(builder.getInt64(1), BB0);
    val4->addIncoming(val7, BB6);
    // %10 = phi i64 [ 1, %3 ], [ %17, %9 ]
    val10->addIncoming(builder.getInt64(1), BB3);
    val10->addIncoming(val17, BB9);
    // %20 = phi i32 [ %68, %67 ], [ 0, %6 ]
    val20->addIncoming(val68, BB67);
    val20->addIncoming(builder.getInt32(0), BB6);
    // %23 = phi i64 [ 514, %19 ], [ %65, %64 ]
    val23->addIncoming(builder.getInt64(514), BB19);
    val23->addIncoming(val65, BB64);

    // ===== INTERPRETER =====

    // Dump LLVM IR
    module->print(outs(), nullptr);

    // LLVM IR Interpreter
    outs() << "[EE] Run\n";
    InitializeNativeTarget();
    InitializeNativeTargetAsmPrinter();

    ExecutionEngine* ee = EngineBuilder(std::unique_ptr<Module>(module)).create();
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
    GenericValue v = ee->runFunction(appFunc, noargs);
    outs() << "[EE] Result: " << v.IntVal << "\n";

    simExit();

    return EXIT_SUCCESS;
}