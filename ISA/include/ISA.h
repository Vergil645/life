// SkipArgs
#define SKIP_3ARGS                                                             \
  { InputFile >> Arg >> Arg >> Arg; }
#define SKIP_2ARGS                                                             \
  { InputFile >> Arg >> Arg; }
#define SKIP_ARG                                                               \
  { InputFile >> Arg; }

// ReadArgs
#define READ_REG(Reg)                                                          \
  {                                                                            \
    InputFile >> Arg;                                                          \
    I.Reg = std::stoi(Arg.substr(1));                                          \
  }
#define READ_IMM                                                               \
  {                                                                            \
    InputFile >> Arg;                                                          \
    I.R3Imm = std::stoll(Arg);                                                 \
  }
#define READ_LABEL                                                             \
  {                                                                            \
    InputFile >> Arg;                                                          \
    if (BBName2PC.find(Arg) == BBName2PC.end()) {                              \
      ErrorMsg = std::string("Can't find label: " + Arg);                      \
      return true;                                                             \
    }                                                                          \
    I.R3Imm = BBName2PC[Arg];                                                  \
  }
#define READ_3REGS                                                             \
  { READ_REG(R1) READ_REG(R2) READ_REG(R3Imm) }
#define READ_2REGS_IMM                                                         \
  { READ_REG(R1) READ_REG(R2) READ_IMM }
#define READ_2REGS                                                             \
  { READ_REG(R1) READ_REG(R2) }
#define READ_REG_IMM                                                           \
  { READ_REG(R1) READ_IMM }
#define READ_REG_LABEL                                                         \
  { READ_REG(R1) READ_LABEL }

// WriteArgs
#define WRITE_REG(Reg)                                                         \
  { Stream << " x" << I.Reg; }
#define WRITE_IMM                                                              \
  { Stream << " " << I.R3Imm; }
#define WRITE_LABEL                                                            \
  { Stream << " " << PC2BBName[I.R3Imm]; }
#define WRITE_3REGS                                                            \
  { WRITE_REG(R1) WRITE_REG(R2) WRITE_REG(R3Imm) }
#define WRITE_2REGS_IMM                                                        \
  { WRITE_REG(R1) WRITE_REG(R2) WRITE_IMM }
#define WRITE_2REGS                                                            \
  { WRITE_REG(R1) WRITE_REG(R2) }
#define WRITE_REG_IMM                                                          \
  { WRITE_REG(R1) WRITE_IMM }
#define WRITE_REG_LABEL                                                        \
  { WRITE_REG(R1) WRITE_LABEL }

// _IRGenExecute
#define GEP2_64(Arg) builder.CreateConstGEP2_64(regFileType, regFile, 0, Arg)
#define LOAD_REG(Arg) builder.CreateLoad(int64Type, GEP2_64(Arg))
#define GEN_IMM(Arg) builder.getInt64(Arg)

// ISA format:
// Opcode
// Name
// SkipArgs: string -> 0 [ifstream InputFile]
// ReadArgs: string -> args [ifstream InputFile, Instr I, map BBName2PC]
// WriteArgs: args -> string [stringstream Stream, Instr I, map PC2BBName]
// Execute: args -> EXECUTION [uint64_t R1, uint64_t R2, uint64_t R3Imm, CPU *C]
// IRGenExecute = args -> IR [IRBuilder builder, regFileType regFile, Instr I, map BBMap, uint64_t PC, Funcs]

// _ISA(_Opcode, _Name, _SkipArgs, _ReadArgs, _WriteArgs, _Execute, _IRGenExecute)



/* ===== GENERAL DESCRIPTION ===== */
/*
Registers are 64 bit (8 byte).
Registers can store positive/negative 64 bit integer numbers in Two's complement form.
Registers can store memory address.

General instruction suffixes:
i - immediate;
b - byte.
*/

/* ===== REGISTERS ===== */

/*
SET_i R1 imm
Write "imm" value to register "R1"
*/
_ISA(
    0x1, SET_i, SKIP_2ARGS, READ_REG_IMM, WRITE_REG_IMM,
    { C->RegFile[R1] = R3Imm; },
    { builder.CreateStore(GEN_IMM(I.R3Imm), GEP2_64(I.R1)); }
)

/* ===== MEMORY ===== */

/*
ALLOC_z R1 imm
Allocate memory block of size "imm" bytes, fill it with zeros and write block start address to register "R1"
*/
_ISA(
    0x2, ALLOC_z, SKIP_2ARGS, READ_REG_IMM, WRITE_REG_IMM,
    { C->RegFile[R1] = C->Alloc(R3Imm); },
    {
        Value* ptr = builder.CreateAlloca(ArrayType::get(int8Type, I.R3Imm));
        builder.CreateCall(memsetFunc, {
            ptr,
            builder.getInt8(0),
            GEN_IMM(I.R3Imm),
            builder.getInt1(false),
        });
        builder.CreateStore(builder.CreatePtrToInt(ptr, int64Type), GEP2_64(I.R1));
    }
)

/*
LOAD_b R1 R2
Read memory cell at address "R2" and write zero-extended value to "R1"
*/
_ISA(
    0x3, LOAD_b, SKIP_2ARGS, READ_2REGS, WRITE_2REGS,
    { C->RegFile[R1] = static_cast<uint64_t>(C->Stack[C->RegFile[R2]]); },
    {
        Value* R2_as_ptr = builder.CreateIntToPtr(LOAD_REG(I.R2), builder.getPtrTy());
        Value* loaded = builder.CreateLoad(int8Type, R2_as_ptr);
        builder.CreateStore(builder.CreateZExt(loaded, int64Type), GEP2_64(I.R1));
    }
)

/*
STORE_b R1 R2 R3
Write "R1[0:7]" value to memory cell at address "R2 + R3"
*/
_ISA(
    0x4, STORE_b, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
    { C->Stack[C->RegFile[R2] + C->RegFile[R3Imm]] = static_cast<uint8_t>(C->RegFile[R1]); },
    {
        Value* R2_as_ptr = builder.CreateIntToPtr(LOAD_REG(I.R2), builder.getPtrTy());
        Value* ptr = builder.CreateGEP(int8Type, R2_as_ptr, { LOAD_REG(I.R3Imm) });
        builder.CreateStore(builder.CreateTrunc(LOAD_REG(I.R1), int8Type), ptr);
    }
)

/*
MEMCPY R1 R2 imm
Copy "imm" bytes to memory block starting at "R1" from memory block starting at address "R2"
*/
_ISA(
    0x5, MEMCPY, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { memcpy(&C->Stack[C->RegFile[R1]], &C->Stack[C->RegFile[R2]], R3Imm); },
    {
        builder.CreateCall(memcpyFunc, {
            builder.CreateIntToPtr(LOAD_REG(I.R1), builder.getPtrTy()),
            builder.CreateIntToPtr(LOAD_REG(I.R2), builder.getPtrTy()),
            GEN_IMM(I.R3Imm),
            builder.getInt1(false)
        });
    }
)

/* ===== ARITHMETIC ===== */

/*
ADD R1 R2 R3
"R1 = R2 + R3"
*/
_ISA(
    0x6, ADD, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
    { C->RegFile[R1] = C->RegFile[R2] + C->RegFile[R3Imm]; },
    { builder.CreateStore(builder.CreateAdd(LOAD_REG(I.R2), LOAD_REG(I.R3Imm)), GEP2_64(I.R1)); }
)

/*
ADD_i R1 R2 imm
"R1 = R2 + imm"
*/
_ISA(
    0x7, ADD_i, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = C->RegFile[R2] + R3Imm; },
    { builder.CreateStore(builder.CreateAdd(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), GEP2_64(I.R1)); }
)

/*
ADD_ASSIGN_LOAD_i R1 R2 imm
"R1 = R1 + zero_extended(load_byte(R2 + imm))"
*/
_ISA(
    0x8, ADD_ASSIGN_LOAD_i, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] += static_cast<uint64_t>(C->Stack[C->RegFile[R2] + R3Imm]); },
    {
        Value* R2_as_ptr = builder.CreateIntToPtr(LOAD_REG(I.R2), builder.getPtrTy());
        Value* ptr = builder.CreateGEP(int8Type, R2_as_ptr, { GEN_IMM(I.R3Imm) });
        Value* loaded = builder.CreateLoad(int8Type, ptr);
        builder.CreateStore(builder.CreateAdd(LOAD_REG(I.R1), builder.CreateZExt(loaded, int64Type)), GEP2_64(I.R1));
    }
)

/*
MUL_i R1 R2 imm
"R1 = R2 * imm"
*/
_ISA(
    0x9, MUL_i, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = C->RegFile[R2] * R3Imm; },
    { builder.CreateStore(builder.CreateMul(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), GEP2_64(I.R1)); }
)

/*
UREM_i R1 R2 imm
"R1 = R2 'unsigned rem' imm"
*/
_ISA(
    0xA, UREM_i, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = C->RegFile[R2] % R3Imm; },
    { builder.CreateStore(builder.CreateURem(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), GEP2_64(I.R1)); }
)

/*
UDIV_i R1 R2 imm
"R1 = R2 'unsigned integer div' imm"
*/
_ISA(
    0xB, UDIV_i, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = C->RegFile[R2] / R3Imm; },
    { builder.CreateStore(builder.CreateUDiv(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), GEP2_64(I.R1)); }
)

/* ===== LOGIC ===== */

/*
AND R1 R2 R3
"R1 = R2 'bitwise AND' R3"
*/
_ISA(
    0xC, AND, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
    { C->RegFile[R1] = C->RegFile[R2] & C->RegFile[R3Imm]; },
    { builder.CreateStore(builder.CreateAnd(LOAD_REG(I.R2), LOAD_REG(I.R3Imm)), GEP2_64(I.R1)); }
)

/*
OR R1 R2 R3
"R1 = R2 'bitwise OR' R3"
*/
_ISA(
    0xD, OR, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
    { C->RegFile[R1] = C->RegFile[R2] | C->RegFile[R3Imm]; },
    { builder.CreateStore(builder.CreateOr(LOAD_REG(I.R2), LOAD_REG(I.R3Imm)), GEP2_64(I.R1)); }
)

/*
ICMP_EQ_i R1 R2 imm
"R1 = zero_extended(1 if R2 == imm else 0)"
*/
_ISA(
    0xE, ICMP_EQ_i, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = (C->RegFile[R2] == R3Imm) ? 1 : 0; },
    {
        Value* res_i1 = builder.CreateICmpEQ(LOAD_REG(I.R2), GEN_IMM(I.R3Imm));
        builder.CreateStore(builder.CreateZExt(res_i1, int64Type), GEP2_64(I.R1));
    }
)

/*
ICMP_NE_i R1 R2 imm
"R1 = zero_extended(1 if R2 != imm else 0)"
*/
_ISA(
    0xF, ICMP_NE_i, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = (C->RegFile[R2] != R3Imm) ? 1 : 0; },
    {
        Value* res_i1 = builder.CreateICmpNE(LOAD_REG(I.R2), GEN_IMM(I.R3Imm));
        builder.CreateStore(builder.CreateZExt(res_i1, int64Type), GEP2_64(I.R1));
    }
)

/*
INC_NE_i R1 R2 imm
"R2 = R2 + 1; R1 = zero_extended(1 if R2 != imm else 0)"
*/
_ISA(
    0x10, INC_NE_i, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = ++C->RegFile[R2] != R3Imm; },
    {
        Value *arg1_p = GEP2_64(I.R2);
        Value *arg1 = builder.CreateAdd(builder.CreateLoad(int64Type, arg1_p), GEN_IMM(1));
        builder.CreateStore(arg1, arg1_p);
        Value* res_i1 = builder.CreateICmpNE(arg1, GEN_IMM(I.R3Imm));
        builder.CreateStore(builder.CreateZExt(res_i1, int64Type), GEP2_64(I.R1));
    }
)

/* ===== EXECUTION ===== */

/*
BR_COND R1 label
Jump to label if "R1[0]" is 1
*/
_ISA(
    0x11, BR_COND, SKIP_2ARGS, READ_REG_LABEL, WRITE_REG_LABEL,
    {
        if (C->RegFile[R1]) {
            C->NextPC = R3Imm;
        }
    },
    {
        PC++;
        builder.CreateCondBr(
            builder.CreateTrunc(LOAD_REG(I.R1), builder.getInt1Ty()),
            BBMap[I.R3Imm], BBMap[PC]
        );
        builder.SetInsertPoint(BBMap[PC]);
        continue;
    }
)

/*
EXIT
Stop execution
*/
_ISA(
    0x12, EXIT, {}, {}, {},
    { C->Run = 0; },
    { builder.CreateRetVoid(); }
)

/* ===== GRAPHICS ===== */

/*
RAND R1
"R1 = zero_extended(simRand())"
*/
_ISA(
    0x13, RAND, SKIP_ARG, READ_REG(R1), WRITE_REG(R1),
    { C->RegFile[R1] = simRand(); },
    {
        Value* res_i32 = builder.CreateCall(simRandFunc);
        builder.CreateStore(builder.CreateZExt(res_i32, int64Type), GEP2_64(I.R1));
    }
)

/*
PUT_PIXEL R1 R2 R3
Call "simPutPixel" with arguments "R1", "R2" and "R3" truncated to 32 bit integer
*/
_ISA(
    0x14, PUT_PIXEL, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
    { simPutPixel(C->RegFile[R1], C->RegFile[R2], C->RegFile[R3Imm]); },
    {
        builder.CreateCall(simPutPixelFunc, {
            builder.CreateTrunc(LOAD_REG(I.R1), builder.getInt32Ty()),
            builder.CreateTrunc(LOAD_REG(I.R2), builder.getInt32Ty()),
            builder.CreateTrunc(LOAD_REG(I.R3Imm), builder.getInt32Ty())
        });
    }
)

/*
FLUSH
Call "simFlush"
*/
_ISA(
    0x15, FLUSH, {}, {}, {},
    { simFlush(); },
    { builder.CreateCall(simFlushFunc); }
)
