; ModuleID = '/home/kmatvey/projects/life/src/app.c'
source_filename = "/home/kmatvey/projects/life/src/app.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local void @app() local_unnamed_addr #0 {
  %1 = alloca [256 x [512 x i32]], align 16
  %2 = alloca [256 x [512 x i32]], align 16
  call void @llvm.lifetime.start.p0(i64 524288, ptr nonnull %1) #5
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(524288) %1, i8 0, i64 524288, i1 false)
  call void @llvm.lifetime.start.p0(i64 524288, ptr nonnull %2) #5
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(524288) %2, i8 0, i64 524288, i1 false)
  br label %3

3:                                                ; preds = %5, %0
  %4 = phi i64 [ 0, %0 ], [ %6, %5 ]
  br label %8

5:                                                ; preds = %8
  %6 = add nuw nsw i64 %4, 1
  %7 = icmp eq i64 %6, 256
  br i1 %7, label %17, label %3, !llvm.loop !5

8:                                                ; preds = %8, %3
  %9 = phi i64 [ 0, %3 ], [ %15, %8 ]
  %10 = tail call i32 (...) @simRand() #5
  %11 = srem i32 %10, 5
  %12 = icmp eq i32 %11, 0
  %13 = zext i1 %12 to i32
  %14 = getelementptr inbounds [256 x [512 x i32]], ptr %1, i64 0, i64 %4, i64 %9
  store i32 %13, ptr %14, align 4
  %15 = add nuw nsw i64 %9, 1
  %16 = icmp eq i64 %15, 512
  br i1 %16, label %5, label %8, !llvm.loop !7

17:                                               ; preds = %5, %30
  %18 = phi i32 [ %31, %30 ], [ 0, %5 ]
  br label %20

19:                                               ; preds = %30
  call void @llvm.lifetime.end.p0(i64 524288, ptr nonnull %2) #5
  call void @llvm.lifetime.end.p0(i64 524288, ptr nonnull %1) #5
  ret void

20:                                               ; preds = %17, %28
  %21 = phi i64 [ 0, %17 ], [ %25, %28 ]
  %22 = icmp eq i64 %21, 0
  %23 = add nsw i64 %21, -1
  %24 = icmp eq i64 %21, 255
  %25 = add nuw nsw i64 %21, 1
  %26 = getelementptr inbounds [256 x [512 x i32]], ptr %1, i64 0, i64 %21, i64 510
  %27 = trunc i64 %21 to i32
  br label %33

28:                                               ; preds = %117
  %29 = icmp eq i64 %25, 256
  br i1 %29, label %30, label %20, !llvm.loop !8

30:                                               ; preds = %28
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(524288) %1, ptr noundef nonnull align 16 dereferenceable(524288) %2, i64 524288, i1 false), !tbaa !9
  tail call void (...) @simFlush() #5
  %31 = add nuw nsw i32 %18, 1
  %32 = icmp eq i32 %31, 1000
  br i1 %32, label %19, label %17, !llvm.loop !13

33:                                               ; preds = %20, %117
  %34 = phi i32 [ 0, %20 ], [ %99, %117 ]
  %35 = zext nneg i32 %34 to i64
  br i1 %22, label %56, label %36

36:                                               ; preds = %33
  %37 = getelementptr inbounds [256 x [512 x i32]], ptr %1, i64 0, i64 %23, i64 %35
  %38 = load i32, ptr %37, align 4, !tbaa !9
  %39 = icmp eq i32 %34, 0
  br i1 %39, label %47, label %40

40:                                               ; preds = %36
  %41 = add nsw i32 %34, -1
  %42 = zext nneg i32 %41 to i64
  %43 = getelementptr inbounds [256 x [512 x i32]], ptr %1, i64 0, i64 %23, i64 %42
  %44 = load i32, ptr %43, align 4, !tbaa !9
  %45 = add nsw i32 %44, %38
  %46 = icmp eq i32 %34, 511
  br i1 %46, label %54, label %47

47:                                               ; preds = %36, %40
  %48 = phi i32 [ %45, %40 ], [ %38, %36 ]
  %49 = add nuw nsw i32 %34, 1
  %50 = zext nneg i32 %49 to i64
  %51 = getelementptr inbounds [256 x [512 x i32]], ptr %1, i64 0, i64 %23, i64 %50
  %52 = load i32, ptr %51, align 4, !tbaa !9
  %53 = add nsw i32 %52, %48
  br label %54

54:                                               ; preds = %40, %47
  %55 = phi i32 [ %53, %47 ], [ %45, %40 ]
  br i1 %24, label %76, label %56

56:                                               ; preds = %33, %54
  %57 = phi i32 [ %55, %54 ], [ 0, %33 ]
  %58 = getelementptr inbounds [256 x [512 x i32]], ptr %1, i64 0, i64 %25, i64 %35
  %59 = load i32, ptr %58, align 4, !tbaa !9
  %60 = add nsw i32 %59, %57
  %61 = icmp eq i32 %34, 0
  br i1 %61, label %69, label %62

62:                                               ; preds = %56
  %63 = add nsw i32 %34, -1
  %64 = zext nneg i32 %63 to i64
  %65 = getelementptr inbounds [256 x [512 x i32]], ptr %1, i64 0, i64 %25, i64 %64
  %66 = load i32, ptr %65, align 4, !tbaa !9
  %67 = add nsw i32 %66, %60
  %68 = icmp eq i32 %34, 511
  br i1 %68, label %92, label %69

69:                                               ; preds = %56, %62
  %70 = phi i32 [ %67, %62 ], [ %60, %56 ]
  %71 = add nuw nsw i32 %34, 1
  %72 = zext nneg i32 %71 to i64
  %73 = getelementptr inbounds [256 x [512 x i32]], ptr %1, i64 0, i64 %25, i64 %72
  %74 = load i32, ptr %73, align 4, !tbaa !9
  %75 = add nsw i32 %74, %70
  br label %76

76:                                               ; preds = %69, %54
  %77 = phi i32 [ %75, %69 ], [ %55, %54 ]
  %78 = icmp eq i32 %34, 0
  br i1 %78, label %87, label %79

79:                                               ; preds = %76
  %80 = add nsw i32 %34, -1
  %81 = zext nneg i32 %80 to i64
  %82 = getelementptr inbounds [256 x [512 x i32]], ptr %1, i64 0, i64 %21, i64 %81
  %83 = load i32, ptr %82, align 4, !tbaa !9
  %84 = add nsw i32 %83, %77
  %85 = add nuw nsw i32 %34, 1
  %86 = icmp eq i32 %34, 511
  br i1 %86, label %98, label %87

87:                                               ; preds = %76, %79
  %88 = phi i32 [ %85, %79 ], [ 1, %76 ]
  %89 = phi i32 [ %84, %79 ], [ %77, %76 ]
  %90 = zext nneg i32 %88 to i64
  %91 = getelementptr inbounds [256 x [512 x i32]], ptr %1, i64 0, i64 %21, i64 %90
  br label %92

92:                                               ; preds = %62, %87
  %93 = phi ptr [ %91, %87 ], [ %26, %62 ]
  %94 = phi i32 [ %89, %87 ], [ %67, %62 ]
  %95 = phi i32 [ %88, %87 ], [ 512, %62 ]
  %96 = load i32, ptr %93, align 4, !tbaa !9
  %97 = add nsw i32 %96, %94
  br label %98

98:                                               ; preds = %92, %79
  %99 = phi i32 [ 512, %79 ], [ %95, %92 ]
  %100 = phi i32 [ %84, %79 ], [ %97, %92 ]
  %101 = zext nneg i32 %34 to i64
  %102 = getelementptr inbounds [256 x [512 x i32]], ptr %1, i64 0, i64 %21, i64 %101
  %103 = load i32, ptr %102, align 4, !tbaa !9
  %104 = icmp eq i32 %103, 0
  br i1 %104, label %111, label %105

105:                                              ; preds = %98
  %106 = add i32 %100, -4
  %107 = icmp ult i32 %106, -2
  %108 = getelementptr inbounds [256 x [512 x i32]], ptr %2, i64 0, i64 %21, i64 %101
  br i1 %107, label %109, label %110

109:                                              ; preds = %105
  store i32 0, ptr %108, align 4, !tbaa !9
  br label %117

110:                                              ; preds = %105
  store i32 1, ptr %108, align 4, !tbaa !9
  br label %117

111:                                              ; preds = %98
  %112 = icmp eq i32 %100, 3
  %113 = getelementptr inbounds [256 x [512 x i32]], ptr %2, i64 0, i64 %21, i64 %101
  br i1 %112, label %116, label %114

114:                                              ; preds = %111
  %115 = load i32, ptr %113, align 4, !tbaa !9
  br label %117

116:                                              ; preds = %111
  store i32 1, ptr %113, align 4, !tbaa !9
  br label %117

117:                                              ; preds = %114, %116, %109, %110
  %118 = phi i32 [ %115, %114 ], [ 1, %116 ], [ 0, %109 ], [ 1, %110 ]
  %119 = mul nsw i32 %118, 16777215
  %120 = add i32 %119, -16777216
  tail call void @simPutPixel(i32 noundef %34, i32 noundef %27, i32 noundef %120) #5
  %121 = icmp ult i32 %99, 512
  br i1 %121, label %33, label %28, !llvm.loop !14
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

declare void @simPutPixel(i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

declare void @simFlush(...) local_unnamed_addr #3

declare i32 @simRand(...) local_unnamed_addr #3

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
!7 = distinct !{!7, !6}
!8 = distinct !{!8, !6}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = distinct !{!13, !6}
!14 = distinct !{!14, !6}
