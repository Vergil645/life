entry
  ALLOC_z x1 132612
  ALLOC_z x2 132612

init_loop
  SET_i x3 1
  SET_i x4 514

init_loop_y
  SET_i x5 1

init_loop_x
  RAND x6
  UREM_i x6 x6 5
  ICMP_EQ_i x6 x6 0
  ADD x7 x4 x5
  STORE_b x6 x1 x7

init_loop_inc_x
  INC_NE_i x8 x5 513
  BR_COND x8 init_loop_x

init_loop_inc_y
  INC_NE_i x9 x3 257
  MUL_i x4 x3 514
  BR_COND x9 init_loop_y

main_loop
  SET_i x3 0

main_loop_step
  SET_i x4 514

main_loop_i
  ADD x5 x1 x4

  UREM_i x6 x4 514
  UDIV_i x7 x4 514
  ICMP_EQ_i x8 x6 513
  ICMP_EQ_i x9 x6 0
  OR x8 x8 x9
  BR_COND x8 main_loop_inc_i

main_loop_i_body
  ADD_i x6 x6 -1
  ADD_i x7 x7 -1
  LOAD_b x8 x5
  MUL_i x8 x8 16777215
  ADD_i x8 x8 4278190080
  PUT_PIXEL x6 x7 x8

  SET_i x6 0
  ADD_ASSIGN_LOAD_i x6 x5 -515
  ADD_ASSIGN_LOAD_i x6 x5 -514
  ADD_ASSIGN_LOAD_i x6 x5 -513
  ADD_ASSIGN_LOAD_i x6 x5 -1
  ADD_ASSIGN_LOAD_i x6 x5 1
  ADD_ASSIGN_LOAD_i x6 x5 513
  ADD_ASSIGN_LOAD_i x6 x5 514
  ADD_ASSIGN_LOAD_i x6 x5 515
  LOAD_b x7 x5

  ICMP_EQ_i x8 x6 3
  ICMP_NE_i x9 x7 0
  ICMP_EQ_i x10 x6 2
  AND x9 x9 x10
  OR x8 x8 x9
  STORE_b x8 x2 x4

main_loop_inc_i
  INC_NE_i x5 x4 132098
  BR_COND x5 main_loop_i

main_loop_inc_step
  MEMCPY x1 x2 132612
  FLUSH
  INC_NE_i x5 x3 1000
  BR_COND x5 main_loop_step

exit
  EXIT