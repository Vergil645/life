; ModuleID = '/home/kmatvey/projects/life/src/app.c'
source_filename = "/home/kmatvey/projects/life/src/app.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local void @app() local_unnamed_addr #0 {
  %1 = alloca [131072 x i32], align 16
  call void @llvm.lifetime.start.p0(i64 524288, ptr nonnull %1) #4
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(524288) %1, i8 0, i64 524288, i1 false)
  br label %2

2:                                                ; preds = %0, %5
  %3 = phi i64 [ 0, %0 ], [ %6, %5 ]
  %4 = shl nuw nsw i64 %3, 9
  br label %8

5:                                                ; preds = %8
  %6 = add nuw nsw i64 %3, 1
  %7 = icmp eq i64 %6, 256
  br i1 %7, label %18, label %2, !llvm.loop !5

8:                                                ; preds = %2, %8
  %9 = phi i64 [ 0, %2 ], [ %16, %8 ]
  %10 = tail call i32 (...) @simRand() #4
  %11 = srem i32 %10, 5
  %12 = icmp eq i32 %11, 0
  %13 = add nuw nsw i64 %9, %4
  %14 = getelementptr inbounds [131072 x i32], ptr %1, i64 0, i64 %13
  %15 = zext i1 %12 to i32
  store i32 %15, ptr %14, align 4, !tbaa !7
  %16 = add nuw nsw i64 %9, 1
  %17 = icmp eq i64 %16, 512
  br i1 %17, label %5, label %8, !llvm.loop !11

18:                                               ; preds = %5, %152
  %19 = phi i32 [ %153, %152 ], [ 0, %5 ]
  br label %21

20:                                               ; preds = %152
  call void @llvm.lifetime.end.p0(i64 524288, ptr nonnull %1) #4
  ret void

21:                                               ; preds = %18, %30
  %22 = phi i32 [ 0, %18 ], [ %31, %30 ]
  %23 = icmp eq i32 %22, 0
  %24 = shl nuw nsw i32 %22, 9
  %25 = add nsw i32 %24, -512
  %26 = icmp eq i32 %22, 255
  %27 = add nuw nsw i32 %24, 512
  %28 = add nsw i32 %24, -1
  %29 = or disjoint i32 %24, 1
  br label %33

30:                                               ; preds = %124
  %31 = add nuw nsw i32 %22, 1
  %32 = icmp eq i32 %31, 256
  br i1 %32, label %130, label %21, !llvm.loop !12

33:                                               ; preds = %21, %124
  %34 = phi i32 [ 0, %21 ], [ %108, %124 ]
  br i1 %23, label %60, label %35

35:                                               ; preds = %33
  %36 = or disjoint i32 %34, %25
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [131072 x i32], ptr %1, i64 0, i64 %37
  %39 = load i32, ptr %38, align 4, !tbaa !7
  %40 = and i32 %39, 1
  %41 = icmp eq i32 %34, 0
  br i1 %41, label %50, label %42

42:                                               ; preds = %35
  %43 = add nsw i32 %36, -1
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [131072 x i32], ptr %1, i64 0, i64 %44
  %46 = load i32, ptr %45, align 4, !tbaa !7
  %47 = and i32 %46, 1
  %48 = add nuw nsw i32 %47, %40
  %49 = icmp eq i32 %34, 511
  br i1 %49, label %58, label %50

50:                                               ; preds = %35, %42
  %51 = phi i32 [ %48, %42 ], [ %40, %35 ]
  %52 = add nsw i32 %36, 1
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [131072 x i32], ptr %1, i64 0, i64 %53
  %55 = load i32, ptr %54, align 4, !tbaa !7
  %56 = and i32 %55, 1
  %57 = add nuw nsw i32 %56, %51
  br label %58

58:                                               ; preds = %42, %50
  %59 = phi i32 [ %57, %50 ], [ %48, %42 ]
  br i1 %26, label %85, label %60

60:                                               ; preds = %33, %58
  %61 = phi i32 [ %59, %58 ], [ 0, %33 ]
  %62 = or disjoint i32 %34, %27
  %63 = zext nneg i32 %62 to i64
  %64 = getelementptr inbounds [131072 x i32], ptr %1, i64 0, i64 %63
  %65 = load i32, ptr %64, align 4, !tbaa !7
  %66 = and i32 %65, 1
  %67 = add nuw nsw i32 %66, %61
  %68 = icmp eq i32 %34, 0
  br i1 %68, label %77, label %69

69:                                               ; preds = %60
  %70 = add nsw i32 %62, -1
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [131072 x i32], ptr %1, i64 0, i64 %71
  %73 = load i32, ptr %72, align 4, !tbaa !7
  %74 = and i32 %73, 1
  %75 = add nuw nsw i32 %74, %67
  %76 = icmp eq i32 %34, 511
  br i1 %76, label %88, label %77

77:                                               ; preds = %60, %69
  %78 = phi i32 [ %75, %69 ], [ %67, %60 ]
  %79 = add nuw nsw i32 %62, 1
  %80 = zext nneg i32 %79 to i64
  %81 = getelementptr inbounds [131072 x i32], ptr %1, i64 0, i64 %80
  %82 = load i32, ptr %81, align 4, !tbaa !7
  %83 = and i32 %82, 1
  %84 = add nuw nsw i32 %83, %78
  br label %85

85:                                               ; preds = %77, %58
  %86 = phi i32 [ %84, %77 ], [ %59, %58 ]
  %87 = icmp eq i32 %34, 0
  br i1 %87, label %98, label %88

88:                                               ; preds = %69, %85
  %89 = phi i32 [ %86, %85 ], [ %75, %69 ]
  %90 = add i32 %28, %34
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds [131072 x i32], ptr %1, i64 0, i64 %91
  %93 = load i32, ptr %92, align 4, !tbaa !7
  %94 = and i32 %93, 1
  %95 = add nuw nsw i32 %94, %89
  %96 = add nuw nsw i32 %34, 1
  %97 = icmp eq i32 %34, 511
  br i1 %97, label %107, label %98

98:                                               ; preds = %85, %88
  %99 = phi i32 [ %96, %88 ], [ 1, %85 ]
  %100 = phi i32 [ %95, %88 ], [ %86, %85 ]
  %101 = add nuw i32 %29, %34
  %102 = zext nneg i32 %101 to i64
  %103 = getelementptr inbounds [131072 x i32], ptr %1, i64 0, i64 %102
  %104 = load i32, ptr %103, align 4, !tbaa !7
  %105 = and i32 %104, 1
  %106 = add nuw nsw i32 %105, %100
  br label %107

107:                                              ; preds = %98, %88
  %108 = phi i32 [ %99, %98 ], [ 512, %88 ]
  %109 = phi i32 [ %106, %98 ], [ %95, %88 ]
  %110 = or disjoint i32 %34, %24
  %111 = zext nneg i32 %110 to i64
  %112 = getelementptr inbounds [131072 x i32], ptr %1, i64 0, i64 %111
  %113 = load i32, ptr %112, align 4, !tbaa !7
  %114 = icmp eq i32 %113, 0
  br i1 %114, label %120, label %115

115:                                              ; preds = %107
  %116 = and i32 %109, -2
  %117 = icmp eq i32 %116, 2
  br i1 %117, label %118, label %124

118:                                              ; preds = %115
  %119 = or i32 %113, 2
  br label %122

120:                                              ; preds = %107
  %121 = icmp eq i32 %109, 3
  br i1 %121, label %122, label %124

122:                                              ; preds = %120, %118
  %123 = phi i32 [ %119, %118 ], [ 2, %120 ]
  store i32 %123, ptr %112, align 4, !tbaa !7
  br label %124

124:                                              ; preds = %122, %120, %115
  %125 = phi i32 [ 0, %120 ], [ %113, %115 ], [ %123, %122 ]
  %126 = ashr i32 %125, 1
  %127 = mul nsw i32 %126, 16777215
  %128 = add i32 %127, -16777216
  tail call void @simPutPixel(i32 noundef %34, i32 noundef %22, i32 noundef %128) #4
  %129 = icmp ult i32 %108, 512
  br i1 %129, label %33, label %30, !llvm.loop !13

130:                                              ; preds = %30, %155
  %131 = phi i64 [ %156, %155 ], [ 0, %30 ]
  %132 = shl nuw nsw i64 %131, 9
  br label %133

133:                                              ; preds = %133, %130
  %134 = phi i64 [ 0, %130 ], [ %150, %133 ]
  %135 = add nuw nsw i64 %134, %132
  %136 = getelementptr inbounds [131072 x i32], ptr %1, i64 0, i64 %135
  %137 = getelementptr inbounds i32, ptr %136, i64 4
  %138 = load <4 x i32>, ptr %136, align 16, !tbaa !7
  %139 = load <4 x i32>, ptr %137, align 16, !tbaa !7
  %140 = ashr <4 x i32> %138, <i32 1, i32 1, i32 1, i32 1>
  %141 = ashr <4 x i32> %139, <i32 1, i32 1, i32 1, i32 1>
  store <4 x i32> %140, ptr %136, align 16, !tbaa !7
  store <4 x i32> %141, ptr %137, align 16, !tbaa !7
  %142 = or disjoint i64 %134, 8
  %143 = add nuw nsw i64 %142, %132
  %144 = getelementptr inbounds [131072 x i32], ptr %1, i64 0, i64 %143
  %145 = getelementptr inbounds i32, ptr %144, i64 4
  %146 = load <4 x i32>, ptr %144, align 16, !tbaa !7
  %147 = load <4 x i32>, ptr %145, align 16, !tbaa !7
  %148 = ashr <4 x i32> %146, <i32 1, i32 1, i32 1, i32 1>
  %149 = ashr <4 x i32> %147, <i32 1, i32 1, i32 1, i32 1>
  store <4 x i32> %148, ptr %144, align 16, !tbaa !7
  store <4 x i32> %149, ptr %145, align 16, !tbaa !7
  %150 = add nuw nsw i64 %134, 16
  %151 = icmp eq i64 %150, 512
  br i1 %151, label %155, label %133, !llvm.loop !14

152:                                              ; preds = %155
  tail call void (...) @simFlush() #4
  %153 = add nuw nsw i32 %19, 1
  %154 = icmp eq i32 %153, 1000
  br i1 %154, label %20, label %18, !llvm.loop !17

155:                                              ; preds = %133
  %156 = add nuw nsw i64 %131, 1
  %157 = icmp eq i64 %156, 256
  br i1 %157, label %152, label %130, !llvm.loop !18
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

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }

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
!14 = distinct !{!14, !6, !15, !16}
!15 = !{!"llvm.loop.isvectorized", i32 1}
!16 = !{!"llvm.loop.unroll.runtime.disable"}
!17 = distinct !{!17, !6}
!18 = distinct !{!18, !6}
