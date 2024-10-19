; ModuleID = 'app'
source_filename = "app"

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #0

declare i32 @simRand()

declare void @simPutPixel(i32, i32, i32)

declare void @simFlush()

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

define void @app() {
  %1 = alloca [132612 x i32], align 4
  %2 = alloca [132612 x i32], align 4
  call void @llvm.memset.p0.i64(ptr %1, i8 0, i64 530448, i1 false)
  call void @llvm.memset.p0.i64(ptr %2, i8 0, i64 530448, i1 false)
  br label %3

3:                                                ; preds = %6, %0
  %4 = phi i64 [ 1, %0 ], [ %7, %6 ]
  %5 = mul nuw nsw i64 %4, 514
  br label %9

6:                                                ; preds = %9
  %7 = add nuw nsw i64 %4, 1
  %8 = icmp eq i64 %7, 257
  br i1 %8, label %19, label %3

9:                                                ; preds = %9, %3
  %10 = phi i64 [ 1, %3 ], [ %17, %9 ]
  %11 = tail call i32 @simRand()
  %12 = srem i32 %11, 5
  %13 = icmp eq i32 %12, 0
  %14 = add nuw nsw i64 %10, %5
  %15 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i64 %14
  %16 = zext i1 %13 to i32
  store i32 %16, ptr %15, align 4
  %17 = add nuw nsw i64 %10, 1
  %18 = icmp eq i64 %17, 513
  br i1 %18, label %6, label %9

19:                                               ; preds = %67, %6
  %20 = phi i32 [ %68, %67 ], [ 0, %6 ]
  br label %22

21:                                               ; preds = %67
  ret void

22:                                               ; preds = %64, %19
  %23 = phi i64 [ 514, %19 ], [ %65, %64 ]
  %24 = trunc i64 %23 to i32
  %25 = urem i32 %24, 514
  %26 = udiv i32 %24, 514
  switch i32 %25, label %27 [
    i32 513, label %64
    i32 0, label %64
  ]

27:                                               ; preds = %22
  %28 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i64 %23
  %29 = add nsw i32 %25, -1
  %30 = add nsw i32 %26, -1
  %31 = load i32, ptr %28, align 4
  %32 = mul nsw i32 %31, 16777215
  %33 = add i32 %32, -16777216
  tail call void @simPutPixel(i32 %29, i32 %30, i32 %33)
  %34 = getelementptr inbounds i32, ptr %28, i64 -514
  %35 = getelementptr inbounds i32, ptr %28, i64 -515
  %36 = load i32, ptr %35, align 4
  %37 = load i32, ptr %34, align 4
  %38 = add nsw i32 %37, %36
  %39 = getelementptr inbounds i32, ptr %28, i64 -513
  %40 = load i32, ptr %39, align 4
  %41 = add nsw i32 %38, %40
  %42 = getelementptr inbounds i32, ptr %28, i64 -1
  %43 = load i32, ptr %42, align 4
  %44 = add nsw i32 %41, %43
  %45 = getelementptr inbounds i32, ptr %28, i64 1
  %46 = load i32, ptr %45, align 4
  %47 = add nsw i32 %44, %46
  %48 = getelementptr inbounds i32, ptr %28, i64 514
  %49 = getelementptr inbounds i32, ptr %28, i64 513
  %50 = load i32, ptr %49, align 4
  %51 = add nsw i32 %47, %50
  %52 = load i32, ptr %48, align 4
  %53 = add nsw i32 %51, %52
  %54 = getelementptr inbounds i32, ptr %28, i64 515
  %55 = load i32, ptr %54, align 4
  %56 = add nsw i32 %53, %55
  %57 = getelementptr inbounds [132612 x i32], ptr %2, i64 0, i64 %23
  %58 = icmp eq i32 %56, 3
  %59 = icmp ne i32 %31, 0
  %60 = icmp eq i32 %56, 2
  %61 = and i1 %59, %60
  %62 = or i1 %58, %61
  %63 = zext i1 %62 to i32
  store i32 %63, ptr %57, align 4
  br label %64

64:                                               ; preds = %27, %22, %22
  %65 = add nuw nsw i64 %23, 1
  %66 = icmp eq i64 %65, 132098
  br i1 %66, label %67, label %22

67:                                               ; preds = %64
  call void @llvm.memcpy.p0.p0.i64(ptr %1, ptr %2, i64 530448, i1 false)
  tail call void @simFlush()
  %68 = add nuw nsw i32 %20, 1
  %69 = icmp eq i32 %68, 1000
  br i1 %69, label %21, label %19
}

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
[EE] Run
