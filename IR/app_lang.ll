; ModuleID = 'top'
source_filename = "top"

declare i32 @simRand()

declare void @simPutPixel(i32, i32, i32)

declare void @simFlush()

define void @main() {
entry:
  %0 = alloca [132612 x i32], align 4
  %1 = alloca [132612 x i32], align 4
  %2 = alloca i32, align 4
  store i32 256, ptr %2, align 4
  %3 = alloca i32, align 4
  store i32 512, ptr %3, align 4
  %4 = alloca i32, align 4
  store i32 514, ptr %4, align 4
  %5 = alloca i32, align 4
  store i32 132612, ptr %5, align 4
  %6 = alloca i32, align 4
  store i32 0, ptr %6, align 4
  br label %loop_begin_1

loop_begin_1:                                     ; preds = %tmp_2, %entry
  %7 = getelementptr i32, ptr %6, i32 0
  %8 = load i32, ptr %7, align 4
  %9 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %8
  store i32 0, ptr %9, align 4
  %10 = getelementptr i32, ptr %6, i32 0
  %11 = getelementptr i32, ptr %6, i32 0
  %12 = load i32, ptr %11, align 4
  %13 = add i32 %12, 1
  store i32 %13, ptr %10, align 4
  %14 = getelementptr i32, ptr %6, i32 0
  %15 = load i32, ptr %14, align 4
  %16 = getelementptr i32, ptr %5, i32 0
  %17 = load i32, ptr %16, align 4
  %18 = icmp sge i32 %15, %17
  %19 = zext i1 %18 to i32
  %20 = icmp ne i32 %19, 0
  br i1 %20, label %loop_end_1, label %tmp_2

loop_end_1:                                       ; preds = %loop_begin_1
  %21 = alloca i32, align 4
  store i32 1, ptr %21, align 4
  %22 = alloca i32, align 4
  store i32 1, ptr %22, align 4
  br label %loop_begin_3

tmp_2:                                            ; preds = %loop_begin_1
  br label %loop_begin_1

loop_begin_3:                                     ; preds = %tmp_7, %loop_end_1
  %23 = getelementptr i32, ptr %22, i32 0
  store i32 1, ptr %23, align 4
  br label %loop_begin_4

loop_end_3:                                       ; preds = %loop_end_4
  %24 = alloca i32, align 4
  store i32 0, ptr %24, align 4
  %25 = alloca i32, align 4
  store i32 0, ptr %25, align 4
  br label %loop_begin_8

loop_begin_4:                                     ; preds = %tmp_6, %loop_begin_3
  %26 = call i32 @simRand()
  %27 = srem i32 %26, 5
  %28 = icmp eq i32 %27, 0
  %29 = zext i1 %28 to i32
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %if_begin_5, label %if_end_5

loop_end_4:                                       ; preds = %if_end_5
  %31 = getelementptr i32, ptr %21, i32 0
  %32 = getelementptr i32, ptr %21, i32 0
  %33 = load i32, ptr %32, align 4
  %34 = add i32 %33, 1
  store i32 %34, ptr %31, align 4
  %35 = getelementptr i32, ptr %21, i32 0
  %36 = load i32, ptr %35, align 4
  %37 = getelementptr i32, ptr %2, i32 0
  %38 = load i32, ptr %37, align 4
  %39 = icmp sgt i32 %36, %38
  %40 = zext i1 %39 to i32
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %loop_end_3, label %tmp_7

if_begin_5:                                       ; preds = %loop_begin_4
  %42 = getelementptr i32, ptr %21, i32 0
  %43 = load i32, ptr %42, align 4
  %44 = getelementptr i32, ptr %4, i32 0
  %45 = load i32, ptr %44, align 4
  %46 = mul i32 %43, %45
  %47 = getelementptr i32, ptr %22, i32 0
  %48 = load i32, ptr %47, align 4
  %49 = add i32 %46, %48
  %50 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %49
  store i32 1, ptr %50, align 4
  br label %if_end_5

if_end_5:                                         ; preds = %if_begin_5, %loop_begin_4
  %51 = getelementptr i32, ptr %22, i32 0
  %52 = getelementptr i32, ptr %22, i32 0
  %53 = load i32, ptr %52, align 4
  %54 = add i32 %53, 1
  store i32 %54, ptr %51, align 4
  %55 = getelementptr i32, ptr %22, i32 0
  %56 = load i32, ptr %55, align 4
  %57 = getelementptr i32, ptr %3, i32 0
  %58 = load i32, ptr %57, align 4
  %59 = icmp sgt i32 %56, %58
  %60 = zext i1 %59 to i32
  %61 = icmp ne i32 %60, 0
  br i1 %61, label %loop_end_4, label %tmp_6

tmp_6:                                            ; preds = %if_end_5
  br label %loop_begin_4

tmp_7:                                            ; preds = %loop_end_4
  br label %loop_begin_3

loop_begin_8:                                     ; preds = %tmp_17, %loop_end_3
  %62 = getelementptr i32, ptr %6, i32 0
  %63 = getelementptr i32, ptr %4, i32 0
  %64 = load i32, ptr %63, align 4
  store i32 %64, ptr %62, align 4
  br label %loop_begin_9

loop_end_8:                                       ; preds = %loop_end_15
  ret void

loop_begin_9:                                     ; preds = %tmp_14, %loop_begin_8
  %65 = getelementptr i32, ptr %22, i32 0
  %66 = getelementptr i32, ptr %6, i32 0
  %67 = load i32, ptr %66, align 4
  %68 = getelementptr i32, ptr %4, i32 0
  %69 = load i32, ptr %68, align 4
  %70 = srem i32 %67, %69
  store i32 %70, ptr %65, align 4
  %71 = getelementptr i32, ptr %21, i32 0
  %72 = getelementptr i32, ptr %6, i32 0
  %73 = load i32, ptr %72, align 4
  %74 = getelementptr i32, ptr %4, i32 0
  %75 = load i32, ptr %74, align 4
  %76 = sdiv i32 %73, %75
  store i32 %76, ptr %71, align 4
  %77 = getelementptr i32, ptr %22, i32 0
  %78 = load i32, ptr %77, align 4
  %79 = icmp eq i32 %78, 0
  %80 = zext i1 %79 to i32
  %81 = getelementptr i32, ptr %22, i32 0
  %82 = load i32, ptr %81, align 4
  %83 = getelementptr i32, ptr %4, i32 0
  %84 = load i32, ptr %83, align 4
  %85 = sub i32 %84, 1
  %86 = icmp eq i32 %82, %85
  %87 = zext i1 %86 to i32
  %88 = add i32 %80, %87
  %89 = icmp eq i32 %88, 0
  %90 = zext i1 %89 to i32
  %91 = icmp ne i32 %90, 0
  br i1 %91, label %if_begin_10, label %if_end_10

loop_end_9:                                       ; preds = %if_end_10
  %92 = getelementptr i32, ptr %6, i32 0
  store i32 0, ptr %92, align 4
  br label %loop_begin_15

if_begin_10:                                      ; preds = %loop_begin_9
  %93 = getelementptr i32, ptr %22, i32 0
  %94 = load i32, ptr %93, align 4
  %95 = sub i32 %94, 1
  %96 = getelementptr i32, ptr %21, i32 0
  %97 = load i32, ptr %96, align 4
  %98 = sub i32 %97, 1
  %99 = getelementptr i32, ptr %6, i32 0
  %100 = load i32, ptr %99, align 4
  %101 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %100
  %102 = load i32, ptr %101, align 4
  %103 = mul i32 16777215, %102
  %104 = add i32 -16777216, %103
  call void @simPutPixel(i32 %95, i32 %98, i32 %104)
  %105 = getelementptr i32, ptr %25, i32 0
  %106 = getelementptr i32, ptr %6, i32 0
  %107 = load i32, ptr %106, align 4
  %108 = getelementptr i32, ptr %4, i32 0
  %109 = load i32, ptr %108, align 4
  %110 = sub i32 %107, %109
  %111 = sub i32 %110, 1
  %112 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %111
  %113 = load i32, ptr %112, align 4
  %114 = getelementptr i32, ptr %6, i32 0
  %115 = load i32, ptr %114, align 4
  %116 = getelementptr i32, ptr %4, i32 0
  %117 = load i32, ptr %116, align 4
  %118 = sub i32 %115, %117
  %119 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %118
  %120 = load i32, ptr %119, align 4
  %121 = add i32 %113, %120
  %122 = getelementptr i32, ptr %6, i32 0
  %123 = load i32, ptr %122, align 4
  %124 = getelementptr i32, ptr %4, i32 0
  %125 = load i32, ptr %124, align 4
  %126 = sub i32 %123, %125
  %127 = add i32 %126, 1
  %128 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %127
  %129 = load i32, ptr %128, align 4
  %130 = add i32 %121, %129
  %131 = getelementptr i32, ptr %6, i32 0
  %132 = load i32, ptr %131, align 4
  %133 = sub i32 %132, 1
  %134 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %133
  %135 = load i32, ptr %134, align 4
  %136 = add i32 %130, %135
  %137 = getelementptr i32, ptr %6, i32 0
  %138 = load i32, ptr %137, align 4
  %139 = add i32 %138, 1
  %140 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %139
  %141 = load i32, ptr %140, align 4
  %142 = add i32 %136, %141
  %143 = getelementptr i32, ptr %6, i32 0
  %144 = load i32, ptr %143, align 4
  %145 = getelementptr i32, ptr %4, i32 0
  %146 = load i32, ptr %145, align 4
  %147 = add i32 %144, %146
  %148 = sub i32 %147, 1
  %149 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %148
  %150 = load i32, ptr %149, align 4
  %151 = add i32 %142, %150
  %152 = getelementptr i32, ptr %6, i32 0
  %153 = load i32, ptr %152, align 4
  %154 = getelementptr i32, ptr %4, i32 0
  %155 = load i32, ptr %154, align 4
  %156 = add i32 %153, %155
  %157 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %156
  %158 = load i32, ptr %157, align 4
  %159 = add i32 %151, %158
  %160 = getelementptr i32, ptr %6, i32 0
  %161 = load i32, ptr %160, align 4
  %162 = getelementptr i32, ptr %4, i32 0
  %163 = load i32, ptr %162, align 4
  %164 = add i32 %161, %163
  %165 = add i32 %164, 1
  %166 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %165
  %167 = load i32, ptr %166, align 4
  %168 = add i32 %159, %167
  store i32 %168, ptr %105, align 4
  %169 = getelementptr i32, ptr %6, i32 0
  %170 = load i32, ptr %169, align 4
  %171 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i32 %170
  store i32 0, ptr %171, align 4
  %172 = getelementptr i32, ptr %25, i32 0
  %173 = load i32, ptr %172, align 4
  %174 = icmp eq i32 %173, 3
  %175 = zext i1 %174 to i32
  %176 = icmp ne i32 %175, 0
  br i1 %176, label %if_begin_11, label %if_end_11

if_end_10:                                        ; preds = %if_end_12, %loop_begin_9
  %177 = getelementptr i32, ptr %6, i32 0
  %178 = getelementptr i32, ptr %6, i32 0
  %179 = load i32, ptr %178, align 4
  %180 = add i32 %179, 1
  store i32 %180, ptr %177, align 4
  %181 = getelementptr i32, ptr %6, i32 0
  %182 = load i32, ptr %181, align 4
  %183 = getelementptr i32, ptr %5, i32 0
  %184 = load i32, ptr %183, align 4
  %185 = getelementptr i32, ptr %4, i32 0
  %186 = load i32, ptr %185, align 4
  %187 = sub i32 %184, %186
  %188 = icmp sge i32 %182, %187
  %189 = zext i1 %188 to i32
  %190 = icmp ne i32 %189, 0
  br i1 %190, label %loop_end_9, label %tmp_14

if_begin_11:                                      ; preds = %if_begin_10
  %191 = getelementptr i32, ptr %6, i32 0
  %192 = load i32, ptr %191, align 4
  %193 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i32 %192
  store i32 1, ptr %193, align 4
  br label %if_end_11

if_end_11:                                        ; preds = %if_begin_11, %if_begin_10
  %194 = getelementptr i32, ptr %25, i32 0
  %195 = load i32, ptr %194, align 4
  %196 = icmp eq i32 %195, 2
  %197 = zext i1 %196 to i32
  %198 = icmp ne i32 %197, 0
  br i1 %198, label %if_begin_12, label %if_end_12

if_begin_12:                                      ; preds = %if_end_11
  %199 = getelementptr i32, ptr %6, i32 0
  %200 = load i32, ptr %199, align 4
  %201 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %200
  %202 = load i32, ptr %201, align 4
  %203 = icmp ne i32 %202, 0
  %204 = zext i1 %203 to i32
  %205 = icmp ne i32 %204, 0
  br i1 %205, label %if_begin_13, label %if_end_13

if_end_12:                                        ; preds = %if_end_13, %if_end_11
  br label %if_end_10

if_begin_13:                                      ; preds = %if_begin_12
  %206 = getelementptr i32, ptr %6, i32 0
  %207 = load i32, ptr %206, align 4
  %208 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i32 %207
  store i32 1, ptr %208, align 4
  br label %if_end_13

if_end_13:                                        ; preds = %if_begin_13, %if_begin_12
  br label %if_end_12

tmp_14:                                           ; preds = %if_end_10
  br label %loop_begin_9

loop_begin_15:                                    ; preds = %tmp_16, %loop_end_9
  %209 = getelementptr i32, ptr %6, i32 0
  %210 = load i32, ptr %209, align 4
  %211 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %210
  %212 = getelementptr i32, ptr %6, i32 0
  %213 = load i32, ptr %212, align 4
  %214 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i32 %213
  %215 = load i32, ptr %214, align 4
  store i32 %215, ptr %211, align 4
  %216 = getelementptr i32, ptr %6, i32 0
  %217 = getelementptr i32, ptr %6, i32 0
  %218 = load i32, ptr %217, align 4
  %219 = add i32 %218, 1
  store i32 %219, ptr %216, align 4
  %220 = getelementptr i32, ptr %6, i32 0
  %221 = load i32, ptr %220, align 4
  %222 = getelementptr i32, ptr %5, i32 0
  %223 = load i32, ptr %222, align 4
  %224 = icmp sge i32 %221, %223
  %225 = zext i1 %224 to i32
  %226 = icmp ne i32 %225, 0
  br i1 %226, label %loop_end_15, label %tmp_16

loop_end_15:                                      ; preds = %loop_begin_15
  call void @simFlush()
  %227 = getelementptr i32, ptr %24, i32 0
  %228 = getelementptr i32, ptr %24, i32 0
  %229 = load i32, ptr %228, align 4
  %230 = add i32 %229, 1
  store i32 %230, ptr %227, align 4
  %231 = getelementptr i32, ptr %24, i32 0
  %232 = load i32, ptr %231, align 4
  %233 = icmp sge i32 %232, 1000
  %234 = zext i1 %233 to i32
  %235 = icmp ne i32 %234, 0
  br i1 %235, label %loop_end_8, label %tmp_17

tmp_16:                                           ; preds = %loop_begin_15
  br label %loop_begin_15

tmp_17:                                           ; preds = %loop_end_15
  br label %loop_begin_8
}
