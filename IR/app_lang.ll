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

loop_begin_8:                                     ; preds = %tmp_18, %loop_end_3
  %62 = getelementptr i32, ptr %6, i32 0
  %63 = getelementptr i32, ptr %4, i32 0
  %64 = load i32, ptr %63, align 4
  store i32 %64, ptr %62, align 4
  br label %loop_begin_9

loop_end_8:                                       ; preds = %loop_end_16
  ret void

loop_begin_9:                                     ; preds = %tmp_15, %loop_begin_8
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
  %79 = icmp ne i32 %78, 0
  %80 = zext i1 %79 to i32
  %81 = icmp ne i32 %80, 0
  br i1 %81, label %if_begin_10, label %if_end_10

loop_end_9:                                       ; preds = %if_end_10
  %82 = getelementptr i32, ptr %6, i32 0
  store i32 0, ptr %82, align 4
  br label %loop_begin_16

if_begin_10:                                      ; preds = %loop_begin_9
  %83 = getelementptr i32, ptr %22, i32 0
  %84 = load i32, ptr %83, align 4
  %85 = getelementptr i32, ptr %4, i32 0
  %86 = load i32, ptr %85, align 4
  %87 = sub i32 %86, 1
  %88 = icmp ne i32 %84, %87
  %89 = zext i1 %88 to i32
  %90 = icmp ne i32 %89, 0
  br i1 %90, label %if_begin_11, label %if_end_11

if_end_10:                                        ; preds = %if_end_11, %loop_begin_9
  %91 = getelementptr i32, ptr %6, i32 0
  %92 = getelementptr i32, ptr %6, i32 0
  %93 = load i32, ptr %92, align 4
  %94 = add i32 %93, 1
  store i32 %94, ptr %91, align 4
  %95 = getelementptr i32, ptr %6, i32 0
  %96 = load i32, ptr %95, align 4
  %97 = getelementptr i32, ptr %5, i32 0
  %98 = load i32, ptr %97, align 4
  %99 = getelementptr i32, ptr %4, i32 0
  %100 = load i32, ptr %99, align 4
  %101 = sub i32 %98, %100
  %102 = icmp sge i32 %96, %101
  %103 = zext i1 %102 to i32
  %104 = icmp ne i32 %103, 0
  br i1 %104, label %loop_end_9, label %tmp_15

if_begin_11:                                      ; preds = %if_begin_10
  %105 = getelementptr i32, ptr %22, i32 0
  %106 = load i32, ptr %105, align 4
  %107 = sub i32 %106, 1
  %108 = getelementptr i32, ptr %21, i32 0
  %109 = load i32, ptr %108, align 4
  %110 = sub i32 %109, 1
  %111 = getelementptr i32, ptr %6, i32 0
  %112 = load i32, ptr %111, align 4
  %113 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %112
  %114 = load i32, ptr %113, align 4
  %115 = mul i32 16777215, %114
  %116 = add i32 -16777216, %115
  call void @simPutPixel(i32 %107, i32 %110, i32 %116)
  %117 = getelementptr i32, ptr %25, i32 0
  %118 = getelementptr i32, ptr %6, i32 0
  %119 = load i32, ptr %118, align 4
  %120 = getelementptr i32, ptr %4, i32 0
  %121 = load i32, ptr %120, align 4
  %122 = sub i32 %119, %121
  %123 = sub i32 %122, 1
  %124 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %123
  %125 = load i32, ptr %124, align 4
  %126 = getelementptr i32, ptr %6, i32 0
  %127 = load i32, ptr %126, align 4
  %128 = getelementptr i32, ptr %4, i32 0
  %129 = load i32, ptr %128, align 4
  %130 = sub i32 %127, %129
  %131 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %130
  %132 = load i32, ptr %131, align 4
  %133 = add i32 %125, %132
  %134 = getelementptr i32, ptr %6, i32 0
  %135 = load i32, ptr %134, align 4
  %136 = getelementptr i32, ptr %4, i32 0
  %137 = load i32, ptr %136, align 4
  %138 = sub i32 %135, %137
  %139 = add i32 %138, 1
  %140 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %139
  %141 = load i32, ptr %140, align 4
  %142 = add i32 %133, %141
  %143 = getelementptr i32, ptr %6, i32 0
  %144 = load i32, ptr %143, align 4
  %145 = sub i32 %144, 1
  %146 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %145
  %147 = load i32, ptr %146, align 4
  %148 = add i32 %142, %147
  %149 = getelementptr i32, ptr %6, i32 0
  %150 = load i32, ptr %149, align 4
  %151 = add i32 %150, 1
  %152 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %151
  %153 = load i32, ptr %152, align 4
  %154 = add i32 %148, %153
  %155 = getelementptr i32, ptr %6, i32 0
  %156 = load i32, ptr %155, align 4
  %157 = getelementptr i32, ptr %4, i32 0
  %158 = load i32, ptr %157, align 4
  %159 = add i32 %156, %158
  %160 = sub i32 %159, 1
  %161 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %160
  %162 = load i32, ptr %161, align 4
  %163 = add i32 %154, %162
  %164 = getelementptr i32, ptr %6, i32 0
  %165 = load i32, ptr %164, align 4
  %166 = getelementptr i32, ptr %4, i32 0
  %167 = load i32, ptr %166, align 4
  %168 = add i32 %165, %167
  %169 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %168
  %170 = load i32, ptr %169, align 4
  %171 = add i32 %163, %170
  %172 = getelementptr i32, ptr %6, i32 0
  %173 = load i32, ptr %172, align 4
  %174 = getelementptr i32, ptr %4, i32 0
  %175 = load i32, ptr %174, align 4
  %176 = add i32 %173, %175
  %177 = add i32 %176, 1
  %178 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %177
  %179 = load i32, ptr %178, align 4
  %180 = add i32 %171, %179
  store i32 %180, ptr %117, align 4
  %181 = getelementptr i32, ptr %6, i32 0
  %182 = load i32, ptr %181, align 4
  %183 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i32 %182
  store i32 0, ptr %183, align 4
  %184 = getelementptr i32, ptr %25, i32 0
  %185 = load i32, ptr %184, align 4
  %186 = icmp eq i32 %185, 3
  %187 = zext i1 %186 to i32
  %188 = icmp ne i32 %187, 0
  br i1 %188, label %if_begin_12, label %if_end_12

if_end_11:                                        ; preds = %if_end_13, %if_begin_10
  br label %if_end_10

if_begin_12:                                      ; preds = %if_begin_11
  %189 = getelementptr i32, ptr %6, i32 0
  %190 = load i32, ptr %189, align 4
  %191 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i32 %190
  store i32 1, ptr %191, align 4
  br label %if_end_12

if_end_12:                                        ; preds = %if_begin_12, %if_begin_11
  %192 = getelementptr i32, ptr %25, i32 0
  %193 = load i32, ptr %192, align 4
  %194 = icmp eq i32 %193, 2
  %195 = zext i1 %194 to i32
  %196 = icmp ne i32 %195, 0
  br i1 %196, label %if_begin_13, label %if_end_13

if_begin_13:                                      ; preds = %if_end_12
  %197 = getelementptr i32, ptr %6, i32 0
  %198 = load i32, ptr %197, align 4
  %199 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %198
  %200 = load i32, ptr %199, align 4
  %201 = icmp ne i32 %200, 0
  %202 = zext i1 %201 to i32
  %203 = icmp ne i32 %202, 0
  br i1 %203, label %if_begin_14, label %if_end_14

if_end_13:                                        ; preds = %if_end_14, %if_end_12
  br label %if_end_11

if_begin_14:                                      ; preds = %if_begin_13
  %204 = getelementptr i32, ptr %6, i32 0
  %205 = load i32, ptr %204, align 4
  %206 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i32 %205
  store i32 1, ptr %206, align 4
  br label %if_end_14

if_end_14:                                        ; preds = %if_begin_14, %if_begin_13
  br label %if_end_13

tmp_15:                                           ; preds = %if_end_10
  br label %loop_begin_9

loop_begin_16:                                    ; preds = %tmp_17, %loop_end_9
  %207 = getelementptr i32, ptr %6, i32 0
  %208 = load i32, ptr %207, align 4
  %209 = getelementptr inbounds [132612 x i32], ptr %0, i64 0, i32 %208
  %210 = getelementptr i32, ptr %6, i32 0
  %211 = load i32, ptr %210, align 4
  %212 = getelementptr inbounds [132612 x i32], ptr %1, i64 0, i32 %211
  %213 = load i32, ptr %212, align 4
  store i32 %213, ptr %209, align 4
  %214 = getelementptr i32, ptr %6, i32 0
  %215 = getelementptr i32, ptr %6, i32 0
  %216 = load i32, ptr %215, align 4
  %217 = add i32 %216, 1
  store i32 %217, ptr %214, align 4
  %218 = getelementptr i32, ptr %6, i32 0
  %219 = load i32, ptr %218, align 4
  %220 = getelementptr i32, ptr %5, i32 0
  %221 = load i32, ptr %220, align 4
  %222 = icmp sge i32 %219, %221
  %223 = zext i1 %222 to i32
  %224 = icmp ne i32 %223, 0
  br i1 %224, label %loop_end_16, label %tmp_17

loop_end_16:                                      ; preds = %loop_begin_16
  call void @simFlush()
  %225 = getelementptr i32, ptr %24, i32 0
  %226 = getelementptr i32, ptr %24, i32 0
  %227 = load i32, ptr %226, align 4
  %228 = add i32 %227, 1
  store i32 %228, ptr %225, align 4
  %229 = getelementptr i32, ptr %24, i32 0
  %230 = load i32, ptr %229, align 4
  %231 = icmp sge i32 %230, 1000
  %232 = zext i1 %231 to i32
  %233 = icmp ne i32 %232, 0
  br i1 %233, label %loop_end_8, label %tmp_18

tmp_17:                                           ; preds = %loop_begin_16
  br label %loop_begin_16

tmp_18:                                           ; preds = %loop_end_16
  br label %loop_begin_8
}
