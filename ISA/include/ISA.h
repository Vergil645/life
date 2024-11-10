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

/* ===== REGISTERS ===== */

_ISA(
    0x1, SET, SKIP_2ARGS, READ_REG_IMM, WRITE_REG_IMM,
    { C->RegFile[R1] = R3Imm; },
    { builder.CreateStore(GEN_IMM(I.R3Imm), GEP2_64(I.R1)); }
)

/* ===== MEMORY ===== */

_ISA(
    0x2, ALLOC_ZERO, SKIP_2ARGS, READ_REG_IMM, WRITE_REG_IMM,
    { C->RegFile[R1] = C->Alloc(R3Imm); },
    {
        Value* ptr = builder.CreateAlloca(ArrayType::get(int64Type, I.R3Imm));
        builder.CreateCall(memsetFunc, {
            ptr,
            builder.getInt8(0),
            GEN_IMM(I.R3Imm * sizeof(uint64_t)),
            builder.getInt1(false),
        });
        builder.CreateStore(builder.CreatePtrToInt(ptr, int64Type), GEP2_64(I.R1));
    }
)

_ISA(
    0x3, LOAD, SKIP_2ARGS, READ_2REGS, WRITE_2REGS,
    { C->RegFile[R1] = C->Stack[C->RegFile[R2]]; },
    {
        Value* R2_as_ptr = builder.CreateIntToPtr(LOAD_REG(I.R2), builder.getPtrTy());
        builder.CreateStore(builder.CreateLoad(int64Type, R2_as_ptr), GEP2_64(I.R1));
    }
)

_ISA(
    0x4, STORE, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
    { C->Stack[C->RegFile[R1] + C->RegFile[R3Imm]] = C->RegFile[R2]; },
    {
        Value* R1_as_ptr = builder.CreateIntToPtr(LOAD_REG(I.R1), builder.getPtrTy());
        Value* ptr = builder.CreateInBoundsGEP(int64Type, R1_as_ptr, { LOAD_REG(I.R3Imm) });
        builder.CreateStore(LOAD_REG(I.R2), ptr);
    }
)

_ISA(
    0x5, MEMCPY, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { memcpy(&C->Stack[C->RegFile[R1]], &C->Stack[C->RegFile[R2]], R3Imm * sizeof(uint64_t)); },
    {
        builder.CreateCall(memcpyFunc, {
            builder.CreateIntToPtr(LOAD_REG(I.R1), builder.getPtrTy()),
            builder.CreateIntToPtr(LOAD_REG(I.R2), builder.getPtrTy()),
            GEN_IMM(I.R3Imm * sizeof(uint64_t)),
            builder.getInt1(false)
        });
    }
)

_ISA(
    0x17, OFFSET, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
    { C->RegFile[R1] = C->RegFile[R2] + C->RegFile[R3Imm]; },
    {
        Value* R2_as_ptr = builder.CreateIntToPtr(LOAD_REG(I.R2), builder.getPtrTy());
        Value* ptr = builder.CreateInBoundsGEP(int64Type, R2_as_ptr, { LOAD_REG(I.R3Imm) });
        builder.CreateStore(builder.CreatePtrToInt(ptr, int64Type), GEP2_64(I.R1));
    }
)

/* ===== ARITHMETIC ===== */

_ISA(
    0x6, ADD, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
    { C->RegFile[R1] = C->RegFile[R2] + C->RegFile[R3Imm]; },
    { builder.CreateStore(builder.CreateAdd(LOAD_REG(I.R2), LOAD_REG(I.R3Imm)), GEP2_64(I.R1)); }
)

_ISA(
    0x7, ADDi, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = C->RegFile[R2] + R3Imm; },
    { builder.CreateStore(builder.CreateAdd(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), GEP2_64(I.R1)); }
)

_ISA(
    0x8, ADD_ASSIGN_LOADi, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] += C->Stack[C->RegFile[R2] + R3Imm]; },
    {
        Value* R2_as_ptr = builder.CreateIntToPtr(LOAD_REG(I.R2), builder.getPtrTy());
        Value* ptr = builder.CreateInBoundsGEP(int64Type, R2_as_ptr, { GEN_IMM(I.R3Imm) });
        builder.CreateStore(builder.CreateAdd(LOAD_REG(I.R1), builder.CreateLoad(int64Type, ptr)), GEP2_64(I.R1));
    }
)

_ISA(
    0xA, MULi, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = C->RegFile[R2] * R3Imm; },
    { builder.CreateStore(builder.CreateMul(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), GEP2_64(I.R1)); }
)

_ISA(
    0xB, REMi, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = C->RegFile[R2] % R3Imm; },
    { builder.CreateStore(builder.CreateURem(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), GEP2_64(I.R1)); }
)

_ISA(
    0xC, DIVi, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = C->RegFile[R2] / R3Imm; },
    { builder.CreateStore(builder.CreateUDiv(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), GEP2_64(I.R1)); }
)

/* ===== LOGIC ===== */

_ISA(
    0xD, AND, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
    { C->RegFile[R1] = C->RegFile[R2] & C->RegFile[R3Imm]; },
    { builder.CreateStore(builder.CreateAnd(LOAD_REG(I.R2), LOAD_REG(I.R3Imm)), GEP2_64(I.R1)); }
)

_ISA(
    0xE, OR, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
    { C->RegFile[R1] = C->RegFile[R2] | C->RegFile[R3Imm]; },
    { builder.CreateStore(builder.CreateOr(LOAD_REG(I.R2), LOAD_REG(I.R3Imm)), GEP2_64(I.R1)); }
)

_ISA(
    0xF, ICMP_EQi, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = (C->RegFile[R2] == R3Imm) ? 1 : 0; },
    { builder.CreateStore(builder.CreateZExt(builder.CreateICmpEQ(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), int64Type), GEP2_64(I.R1)); }
)

_ISA(
    0x10, ICMP_NEi, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = (C->RegFile[R2] != R3Imm) ? 1 : 0; },
    { builder.CreateStore(builder.CreateZExt(builder.CreateICmpNE(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), int64Type), GEP2_64(I.R1)); }
)

_ISA(
    0x11, INC_NEi, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
    { C->RegFile[R1] = ++C->RegFile[R2] != R3Imm; },
    {
        Value *arg1_p = GEP2_64(I.R2);
        Value *arg1 = builder.CreateAdd(builder.CreateLoad(int64Type, arg1_p), GEN_IMM(1));
        builder.CreateStore(arg1, arg1_p);
        builder.CreateStore(builder.CreateZExt(builder.CreateICmpNE(arg1, GEN_IMM(I.R3Imm)), int64Type), GEP2_64(I.R1));
    }
)

/* ===== EXECUTION ===== */

_ISA(
    0x12, BR_COND, SKIP_2ARGS, READ_REG_LABEL, WRITE_REG_LABEL,
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

_ISA(
    0x13, EXIT, {}, {}, {},
    { C->Run = 0; },
    { builder.CreateRetVoid(); }
)

/* ===== GRAPHICS ===== */

_ISA(
    0x14, RAND, SKIP_ARG, READ_REG(R1), WRITE_REG(R1),
    { C->RegFile[R1] = simRand(); },
    { builder.CreateStore(builder.CreateCall(simRandFunc), GEP2_64(I.R1)); }
)

_ISA(
    0x15, PUT_PIXEL, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
    { simPutPixel(C->RegFile[R1], C->RegFile[R2], C->RegFile[R3Imm]); },
    {
        builder.CreateCall(simPutPixelFunc, {
            builder.CreateTrunc(LOAD_REG(I.R1), builder.getInt32Ty()),
            builder.CreateTrunc(LOAD_REG(I.R2), builder.getInt32Ty()),
            builder.CreateTrunc(LOAD_REG(I.R3Imm), builder.getInt32Ty())
        });
    }
)

_ISA(
    0x16, FLUSH, {}, {}, {},
    { simFlush(); },
    { builder.CreateCall(simFlushFunc); }
)
