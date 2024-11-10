entry
  ALLOC_ZERO x1 132612
  ALLOC_ZERO x2 132612

init_loop
  SET x3 1
  SET x4 514

init_loop_y
  SET x5 1

init_loop_x
  RAND x6
  REMi x6 x6 5
  ICMP_EQi x6 x6 0
  ADD x7 x4 x5
  STORE x1 x6 x7

init_loop_inc_x
  INC_NEi x8 x5 513
  BR_COND x8 init_loop_x

init_loop_inc_y
  INC_NEi x9 x3 257
  MULi x4 x3 514
  BR_COND x9 init_loop_y

main_loop
  SET x3 0

main_loop_step
  SET x4 514

main_loop_i
  OFFSET x5 x1 x4

  REMi x6 x4 514
  DIVi x7 x4 514
  ICMP_EQi x8 x6 513
  ICMP_EQi x9 x6 0
  OR x8 x8 x9
  BR_COND x8 main_loop_inc_i

main_loop_i_body
  ADDi x6 x6 -1
  ADDi x7 x7 -1
  LOAD x8 x5
  MULi x8 x8 16777215
  ADDi x8 x8 4278190080
  PUT_PIXEL x6 x7 x8

  SET x6 0
  ADD_ASSIGN_LOADi x6 x5 -515
  ADD_ASSIGN_LOADi x6 x5 -514
  ADD_ASSIGN_LOADi x6 x5 -513
  ADD_ASSIGN_LOADi x6 x5 -1
  ADD_ASSIGN_LOADi x6 x5 1
  ADD_ASSIGN_LOADi x6 x5 513
  ADD_ASSIGN_LOADi x6 x5 514
  ADD_ASSIGN_LOADi x6 x5 515
  LOAD x7 x5

  ICMP_EQi x8 x6 3
  ICMP_NEi x9 x7 0
  ICMP_EQi x10 x6 2
  AND x9 x9 x10
  OR x8 x8 x9
  STORE x2 x8 x4

main_loop_inc_i
  INC_NEi x5 x4 132098
  BR_COND x5 main_loop_i

main_loop_inc_step
  MEMCPY x1 x2 132612
  FLUSH
  INC_NEi x5 x3 1000
  BR_COND x5 main_loop_step

exit
  EXIT