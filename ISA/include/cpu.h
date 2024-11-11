#ifndef CPU_H
#define CPU_H
extern "C" {
#include "sim.h"
}
#include "bin.h"
#include "llvm/Support/raw_ostream.h"
#include <cstdint>
#include <cstring>
#include <string>

#define CPU_STACK_SIZE (1024 * 1024)

struct CPU {
  static constexpr size_t RegSize = 16;
  uint64_t RegFile[RegSize] = {};
  uint64_t PC{0};
  uint64_t NextPC{0};
  uint64_t Run{0};
  uint64_t StackPtr{0};
  uint8_t* Stack{0};
  bool DumpInstrs = false;

  CPU();
  ~CPU();

  bool Execute(Binary &Bin, std::string &ErrorMsg);
  std::string dumpStatus();

  uint64_t Alloc(uint64_t size);

  static CPU *C;
  static void setCPU(CPU *Cpu) { C = Cpu; }
#define _ISA(_Opcode, _Name, _SkipArgs, _ReadArgs, _WriteArgs, _Execute,       \
             _IRGenExecute)                                                    \
  static void do_##_Name(uint64_t R1, uint64_t R2, uint64_t R3Imm) {           \
    if (C->DumpInstrs)                                                         \
      llvm::outs() << #_Name "\n";                                             \
    _Execute;                                                                  \
  }
#include "ISA.h"
#undef _ISA
};
#endif // CPU_H
