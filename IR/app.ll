; ModuleID = '/home/kmatvey/projects/life/src/app.c'
source_filename = "/home/kmatvey/projects/life/src/app.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local void @app() local_unnamed_addr #0 {
  %1 = alloca [132612 x i32], align 16
  %2 = alloca [132612 x i32], align 16
  call void @llvm.lifetime.start.p0(i64 530448, ptr nonnull %1) #5
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(530448) %1, i8 0, i64 530448, i1 false)
  call void @llvm.lifetime.start.p0(i64 530448, ptr nonnull %2) #5
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(530448) %2, i8 0, i64 530448, i1 false)
  br label %3

3:                                                ; preds = %0, %6
  %4 = phi i64 [ 1, %0 ], [ %7, %6 ]
  %5 = mul nuw nsw i64 %4, 514
  br label %9

6:                                                ; preds = %9
  %7 = add nuw nsw i64 %4, 1
  %8 = icmp eq i64 %7, 257
  br i1 %8, label %19, label %3, !llvm.loop !5

9:                                                ; preds = %3, %9
  %10 = phi i64 [ 1, %3 ], [ %17, %9 ]
  %11 = tail call i32 (...) @simRand() #5
  %12 = srem i32 %11, 5
  %13 = icmp eq i32 %12, 0
  %14 = add nuw nsw i64 %10, %5
  %15 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i64 %14
  %16 = zext i1 %13 to i32
  store i32 %16, ptr %15, align 4, !tbaa !7
  %17 = add nuw nsw i64 %10, 1
  %18 = icmp eq i64 %17, 513
  br i1 %18, label %6, label %9, !llvm.loop !11

19:                                               ; preds = %6, %67
  %20 = phi i32 [ %68, %67 ], [ 0, %6 ]
  br label %22

21:                                               ; preds = %67
  call void @llvm.lifetime.end.p0(i64 530448, ptr nonnull %2) #5
  call void @llvm.lifetime.end.p0(i64 530448, ptr nonnull %1) #5
  ret void

22:                                               ; preds = %19, %64
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
  %31 = load i32, ptr %28, align 4, !tbaa !7
  %32 = mul nsw i32 %31, 16777215
  %33 = add i32 %32, -16777216
  tail call void @simPutPixel(i32 noundef %29, i32 noundef %30, i32 noundef %33) #5
  %34 = getelementptr inbounds i32, ptr %28, i64 -514
  %35 = getelementptr inbounds i32, ptr %28, i64 -515
  %36 = load i32, ptr %35, align 4, !tbaa !7
  %37 = load i32, ptr %34, align 4, !tbaa !7
  %38 = add nsw i32 %37, %36
  %39 = getelementptr inbounds i32, ptr %28, i64 -513
  %40 = load i32, ptr %39, align 4, !tbaa !7
  %41 = add nsw i32 %38, %40
  %42 = getelementptr inbounds i32, ptr %28, i64 -1
  %43 = load i32, ptr %42, align 4, !tbaa !7
  %44 = add nsw i32 %41, %43
  %45 = getelementptr inbounds i32, ptr %28, i64 1
  %46 = load i32, ptr %45, align 4, !tbaa !7
  %47 = add nsw i32 %44, %46
  %48 = getelementptr inbounds i32, ptr %28, i64 514
  %49 = getelementptr inbounds i32, ptr %28, i64 513
  %50 = load i32, ptr %49, align 4, !tbaa !7
  %51 = add nsw i32 %47, %50
  %52 = load i32, ptr %48, align 4, !tbaa !7
  %53 = add nsw i32 %51, %52
  %54 = getelementptr inbounds i32, ptr %28, i64 515
  %55 = load i32, ptr %54, align 4, !tbaa !7
  %56 = add nsw i32 %53, %55
  %57 = getelementptr inbounds [132612 x i32], ptr %2, i64 0, i64 %23
  %58 = icmp eq i32 %56, 3
  %59 = icmp ne i32 %31, 0
  %60 = icmp eq i32 %56, 2
  %61 = and i1 %59, %60
  %62 = or i1 %58, %61
  %63 = zext i1 %62 to i32
  store i32 %63, ptr %57, align 4, !tbaa !7
  br label %64

64:                                               ; preds = %22, %22, %27
  %65 = add nuw nsw i64 %23, 1
  %66 = icmp eq i64 %65, 132098
  br i1 %66, label %67, label %22, !llvm.loop !12

67:                                               ; preds = %64
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(530448) %1, ptr noundef nonnull align 16 dereferenceable(530448) %2, i64 530448, i1 false), !tbaa !7
  tail call void (...) @simFlush() #5
  %68 = add nuw nsw i32 %20, 1
  %69 = icmp eq i32 %68, 1000
  br i1 %69, label %21, label %19, !llvm.loop !13
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

declare i32 @simRand(...) local_unnamed_addr #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

declare void @simPutPixel(i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #3

declare void @simFlush(...) local_unnamed_addr #3

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #4

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Debian clang version 18.1.8 (++20240731024826+3b5b5c1ec4a3-1~exp1~20240731144843.145)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = distinct !{!11, !6}
!12 = distinct !{!12, !6}
!13 = distinct !{!13, !6}
