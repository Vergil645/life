#include "cpu.h"
#include <sstream>
using namespace std;

CPU *CPU::C;

CPU::CPU(): Stack(new uint8_t[CPU_STACK_SIZE]) {}

CPU::~CPU() {
  delete[] this->Stack;
}

bool CPU::Execute(Binary &Bin, string &ErrorMsg) {
  PC = 0;
  Run = 1;
  setCPU(this);
  simInit();
  while (Run) {
    Instr I = Bin.Instrs[PC];
    NextPC = PC + 1;
    switch (I.Op) {
    default:
      ErrorMsg = string("Wrong Opcode: " + to_string(Bin.Instrs[PC].Op));
      return true;
#define _ISA(_Opcode, _Name, _SkipArgs, _ReadArgs, _WriteArgs, _Execute,       \
             _IRGenExecute)                                                    \
  case (_Opcode):                                                              \
    do_##_Name(I.R1, I.R2, I.R3Imm);                                           \
    break;
#include "ISA.h"
#undef _ISA
    }
    PC = NextPC;
  }
  simExit();
  return false;
}

string CPU::dumpStatus() {
  stringstream Stream;
  for (uint64_t i = 0; i < RegSize; i++) {
    Stream << " x" << i << ":" << RegFile[i];
  }
  Stream << " PC:" << PC << "\n";
  return Stream.str();
}

uint64_t CPU::Alloc(uint64_t size) {
  if (this->StackPtr + size > CPU_STACK_SIZE)
    throw std::runtime_error("Not enough space in CPU stack");

  uint64_t Ptr = this->StackPtr;
  this->StackPtr += size;

  memset(&this->Stack[Ptr], 0, size * sizeof(uint8_t));

  return Ptr;
}