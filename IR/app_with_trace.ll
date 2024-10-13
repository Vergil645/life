; ModuleID = '/home/kmatvey/projects/life/src/app.c'
source_filename = "/home/kmatvey/projects/life/src/app.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@0 = private unnamed_addr constant [7 x i8] c"alloca\00", align 1
@1 = private unnamed_addr constant [5 x i8] c"srem\00", align 1
@2 = private unnamed_addr constant [6 x i8] c"trunc\00", align 1
@3 = private unnamed_addr constant [5 x i8] c"urem\00", align 1
@4 = private unnamed_addr constant [7 x i8] c"switch\00", align 1
@5 = private unnamed_addr constant [5 x i8] c"udiv\00", align 1
@6 = private unnamed_addr constant [4 x i8] c"mul\00", align 1
@7 = private unnamed_addr constant [5 x i8] c"call\00", align 1
@8 = private unnamed_addr constant [5 x i8] c"load\00", align 1
@9 = private unnamed_addr constant [14 x i8] c"getelementptr\00", align 1
@10 = private unnamed_addr constant [4 x i8] c"and\00", align 1
@11 = private unnamed_addr constant [3 x i8] c"or\00", align 1
@12 = private unnamed_addr constant [5 x i8] c"zext\00", align 1
@13 = private unnamed_addr constant [6 x i8] c"store\00", align 1
@14 = private unnamed_addr constant [4 x i8] c"add\00", align 1
@15 = private unnamed_addr constant [5 x i8] c"icmp\00", align 1
@16 = private unnamed_addr constant [3 x i8] c"br\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @app() local_unnamed_addr #0 {
  call void @useLogger(ptr @0, ptr @7)
  call void @useLogger(ptr @0, ptr @7)
  call void @useLogger(ptr @0, ptr @9)
  call void @useLogger(ptr @0, ptr @9)
  call void @useLogger(ptr @0, ptr @7)
  call void @useLogger(ptr @0, ptr @7)
  %1 = alloca [132612 x i32], align 16
  call void @useLogger(ptr @0, ptr @7)
  call void @useLogger(ptr @0, ptr @7)
  call void @useLogger(ptr @0, ptr @9)
  call void @useLogger(ptr @0, ptr @7)
  call void @useLogger(ptr @0, ptr @7)
  %2 = alloca [132612 x i32], align 16
  call void @llvm.lifetime.start.p0(i64 530448, ptr nonnull %1) #5
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(530448) %1, i8 0, i64 530448, i1 false)
  call void @llvm.lifetime.start.p0(i64 530448, ptr nonnull %2) #5
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(530448) %2, i8 0, i64 530448, i1 false)
  br label %3

3:                                                ; preds = %0, %6
  %4 = phi i64 [ 1, %0 ], [ %7, %6 ]
  call void @useLogger(ptr @6, ptr @14)
  %5 = mul nuw nsw i64 %4, 514
  br label %9

6:                                                ; preds = %9
  call void @useLogger(ptr @14, ptr @15)
  %7 = add nuw nsw i64 %4, 1
  call void @useLogger(ptr @15, ptr @16)
  %8 = icmp eq i64 %7, 257
  br i1 %8, label %19, label %3, !llvm.loop !5

9:                                                ; preds = %3, %9
  %10 = phi i64 [ 1, %3 ], [ %17, %9 ]
  call void @useLogger(ptr @7, ptr @1)
  %11 = tail call i32 (...) @simRand() #5
  call void @useLogger(ptr @1, ptr @15)
  %12 = srem i32 %11, 5
  call void @useLogger(ptr @15, ptr @12)
  %13 = icmp eq i32 %12, 0
  call void @useLogger(ptr @14, ptr @9)
  %14 = add nuw nsw i64 %10, %5
  call void @useLogger(ptr @9, ptr @13)
  %15 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i64 %14
  call void @useLogger(ptr @12, ptr @13)
  %16 = zext i1 %13 to i32
  store i32 %16, ptr %15, align 4, !tbaa !7
  call void @useLogger(ptr @14, ptr @15)
  %17 = add nuw nsw i64 %10, 1
  call void @useLogger(ptr @15, ptr @16)
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
  call void @useLogger(ptr @2, ptr @5)
  call void @useLogger(ptr @2, ptr @3)
  %24 = trunc i64 %23 to i32
  call void @useLogger(ptr @3, ptr @4)
  call void @useLogger(ptr @3, ptr @14)
  %25 = urem i32 %24, 514
  call void @useLogger(ptr @5, ptr @14)
  %26 = udiv i32 %24, 514
  switch i32 %25, label %27 [
    i32 513, label %64
    i32 0, label %64
  ]

27:                                               ; preds = %22
  call void @useLogger(ptr @9, ptr @9)
  call void @useLogger(ptr @9, ptr @9)
  call void @useLogger(ptr @9, ptr @9)
  call void @useLogger(ptr @9, ptr @9)
  call void @useLogger(ptr @9, ptr @8)
  call void @useLogger(ptr @9, ptr @9)
  call void @useLogger(ptr @9, ptr @9)
  call void @useLogger(ptr @9, ptr @9)
  call void @useLogger(ptr @9, ptr @9)
  %28 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i64 %23
  call void @useLogger(ptr @14, ptr @7)
  %29 = add nsw i32 %25, -1
  call void @useLogger(ptr @14, ptr @7)
  %30 = add nsw i32 %26, -1
  call void @useLogger(ptr @8, ptr @15)
  call void @useLogger(ptr @8, ptr @6)
  %31 = load i32, ptr %28, align 4, !tbaa !7
  call void @useLogger(ptr @6, ptr @14)
  %32 = mul nsw i32 %31, 16777215
  call void @useLogger(ptr @14, ptr @7)
  %33 = add i32 %32, -16777216
  tail call void @simPutPixel(i32 noundef %29, i32 noundef %30, i32 noundef %33) #5
  call void @useLogger(ptr @9, ptr @8)
  %34 = getelementptr inbounds i32, ptr %28, i64 -514
  call void @useLogger(ptr @9, ptr @8)
  %35 = getelementptr inbounds i32, ptr %28, i64 -515
  call void @useLogger(ptr @8, ptr @14)
  %36 = load i32, ptr %35, align 4, !tbaa !7
  call void @useLogger(ptr @8, ptr @14)
  %37 = load i32, ptr %34, align 4, !tbaa !7
  call void @useLogger(ptr @14, ptr @14)
  %38 = add nsw i32 %37, %36
  call void @useLogger(ptr @9, ptr @8)
  %39 = getelementptr inbounds i32, ptr %28, i64 -513
  call void @useLogger(ptr @8, ptr @14)
  %40 = load i32, ptr %39, align 4, !tbaa !7
  call void @useLogger(ptr @14, ptr @14)
  %41 = add nsw i32 %38, %40
  call void @useLogger(ptr @9, ptr @8)
  %42 = getelementptr inbounds i32, ptr %28, i64 -1
  call void @useLogger(ptr @8, ptr @14)
  %43 = load i32, ptr %42, align 4, !tbaa !7
  call void @useLogger(ptr @14, ptr @14)
  %44 = add nsw i32 %41, %43
  call void @useLogger(ptr @9, ptr @8)
  %45 = getelementptr inbounds i32, ptr %28, i64 1
  call void @useLogger(ptr @8, ptr @14)
  %46 = load i32, ptr %45, align 4, !tbaa !7
  call void @useLogger(ptr @14, ptr @14)
  %47 = add nsw i32 %44, %46
  call void @useLogger(ptr @9, ptr @8)
  %48 = getelementptr inbounds i32, ptr %28, i64 514
  call void @useLogger(ptr @9, ptr @8)
  %49 = getelementptr inbounds i32, ptr %28, i64 513
  call void @useLogger(ptr @8, ptr @14)
  %50 = load i32, ptr %49, align 4, !tbaa !7
  call void @useLogger(ptr @14, ptr @14)
  %51 = add nsw i32 %47, %50
  call void @useLogger(ptr @8, ptr @14)
  %52 = load i32, ptr %48, align 4, !tbaa !7
  call void @useLogger(ptr @14, ptr @14)
  %53 = add nsw i32 %51, %52
  call void @useLogger(ptr @9, ptr @8)
  %54 = getelementptr inbounds i32, ptr %28, i64 515
  call void @useLogger(ptr @8, ptr @14)
  %55 = load i32, ptr %54, align 4, !tbaa !7
  call void @useLogger(ptr @14, ptr @15)
  call void @useLogger(ptr @14, ptr @15)
  %56 = add nsw i32 %53, %55
  call void @useLogger(ptr @9, ptr @13)
  %57 = getelementptr inbounds [132612 x i32], ptr %2, i64 0, i64 %23
  call void @useLogger(ptr @15, ptr @11)
  %58 = icmp eq i32 %56, 3
  call void @useLogger(ptr @15, ptr @10)
  %59 = icmp ne i32 %31, 0
  call void @useLogger(ptr @15, ptr @10)
  %60 = icmp eq i32 %56, 2
  call void @useLogger(ptr @10, ptr @11)
  %61 = and i1 %59, %60
  call void @useLogger(ptr @11, ptr @12)
  %62 = or i1 %58, %61
  call void @useLogger(ptr @12, ptr @13)
  %63 = zext i1 %62 to i32
  store i32 %63, ptr %57, align 4, !tbaa !7
  br label %64

64:                                               ; preds = %22, %22, %27
  call void @useLogger(ptr @14, ptr @15)
  %65 = add nuw nsw i64 %23, 1
  call void @useLogger(ptr @15, ptr @16)
  %66 = icmp eq i64 %65, 132098
  br i1 %66, label %67, label %22, !llvm.loop !12

67:                                               ; preds = %64
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(530448) %1, ptr noundef nonnull align 16 dereferenceable(530448) %2, i64 530448, i1 false), !tbaa !7
  tail call void (...) @simFlush() #5
  call void @useLogger(ptr @14, ptr @15)
  %68 = add nuw nsw i32 %20, 1
  call void @useLogger(ptr @15, ptr @16)
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

declare void @useLogger(ptr, ptr)

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
