%{
#include <iostream>
#include <stdexcept>
#include <map>
#include <vector>

#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/TargetSelect.h"

using namespace llvm;

#define YYSTYPE Value*
extern "C" {
    int yyparse();
    int yylex();
    void yyerror(char *s) {
        throw std::runtime_error(s);
        // std::cerr << s << "\n";
    }
    int yywrap(void){return 1;}
}

LLVMContext context;
IRBuilder<>* builder;
Module* module;
Function *curFunc;
FunctionCallee simRandFunc;
FunctionCallee simPutPixelFunc;
FunctionCallee simFlushFunc;

std::map<std::string, Value*> ValueMap;
std::map<std::string, Type*> TypeMap;
std::map<std::string, BasicBlock*> BBMap;

struct if_t {
    std::string begin_label;
    std::string end_label;

    if_t(std::string begin_label, std::string end_label): begin_label(begin_label), end_label(end_label) {}
};
std::vector<if_t> NestedIf;

struct loop_t {
    std::string begin_label;
    std::string end_label;

    loop_t(std::string begin_label, std::string end_label): begin_label(begin_label), end_label(end_label) {}
};
std::vector<loop_t> NestedLoop;

uint64_t cur_id = 0;
std::string genId() {
    return std::to_string(++cur_id);
}

int main(int argc, char **argv)
{
    // ; ModuleID = 'top'
    // source_filename = "top"
    module = new Module("top", context);
    builder = new IRBuilder<>(context);

    {
        // declare i32 @simRand(...) local_unnamed_addr #3
        FunctionType* simRandFuncType = FunctionType::get(builder->getInt32Ty(), false);
        simRandFunc = module->getOrInsertFunction("simRand", simRandFuncType);
    }

    {
        // declare void @simPutPixel(i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #3
        ArrayRef<Type*> simPutPixelParamTypes = {
            builder->getInt32Ty(),
            builder->getInt32Ty(),
            builder->getInt32Ty(),
        };
        FunctionType* simPutPixelFuncType = FunctionType::get(builder->getVoidTy(), simPutPixelParamTypes, false);
        simPutPixelFunc = module->getOrInsertFunction("simPutPixel", simPutPixelFuncType);
    }

    {
        // declare void @simFlush(...) local_unnamed_addr #3
        FunctionType* simFlushFuncType = FunctionType::get(builder->getVoidTy(), false);
        simFlushFunc = module->getOrInsertFunction("simFlush", simFlushFuncType);
    }

    yyparse();

    if (verifyModule(*module, &outs())) {
        outs() << "[VERIFICATION] FAIL\n";
        return 1;
    }

    module->print(outs(), nullptr);

    return 0;
}
%}

%token IntLiteral
%token LetToken
%token IfToken
%token LoopToken
%token ContinueToken
%token BreakToken
%token FnToken
%token RandToken
%token PutToken
%token FlushToken
%token Identifier

%%

Parse:      Program { YYACCEPT; }
            ;

Program:    FunctionDeclaration {}
            | Program FunctionDeclaration {}
            ;

FunctionDeclaration: FnToken Identifier '(' ')' '{' {
                            // declare void @Identifier()
                            Function *func = module->getFunction((char*)$2);
                            if (func != nullptr) {
                                throw std::runtime_error(std::string("Function '") + (char*)$2 + "' has already been declared");
                            }
                            FunctionType *funcType = FunctionType::get(builder->getVoidTy(), false);
                            func = Function::Create(funcType, Function::ExternalLinkage, (char*)$2, module);
                            curFunc = func;
                            // entry:
                            BasicBlock *entryBB = BasicBlock::Create(context, "entry", curFunc);
                            builder->SetInsertPoint(entryBB);
                        } Statements '}' {
                            builder->CreateRetVoid();
                        }
            ;

Statements: Declaration {}
            | Assignment {}
            | Put {}
            | Flush {}
            | FunctionCall {}
            | IfStatement {}
            | LoopStatement {}
            | ContinueStatement {}
            | BreakStatement {}
            | Statements Declaration {}
            | Statements Assignment {}
            | Statements Put {}
            | Statements Flush {}
            | Statements FunctionCall {}
            | Statements IfStatement {}
            | Statements LoopStatement {}
            | Statements ContinueStatement {}
            | Statements BreakStatement {}
            ;

Put:        PutToken '(' Expression ',' Expression ',' Expression ')' ';' {
                            Value *args[] = {$3, $5, $7};
                            builder->CreateCall(simPutPixelFunc, args);
                        }
            ;

Flush:      FlushToken ';' { builder->CreateCall(simFlushFunc); }
            ;

Declaration: LetToken Identifier '=' Expression ';' {
                            if (ValueMap.find((char*)$2) != ValueMap.end()) {
                                throw std::runtime_error(std::string("Variable '") + (char*)$2 + "' has already been declared");
                            }
                            ValueMap.insert({(char*)$2, builder->CreateAlloca(builder->getInt32Ty())});
                            builder->CreateStore($4, ValueMap[(char*)$2]);
                        }
            | LetToken Identifier '[' IntLiteral ']' ';' {
                            if (ValueMap.find((char*)$2) != ValueMap.end()) {
                                throw std::runtime_error(std::string("Variable '") + (char*)$2 + "' has already been declared");
                            }
                            TypeMap.insert({(char*)$2, ArrayType::get(builder->getInt32Ty(), atoi((char*)$4))});
                            ValueMap.insert({(char*)$2, builder->CreateAlloca(TypeMap[(char*)$2])});
                        }
            ;

Assignment: Value '=' Expression ';' { builder->CreateStore($3, $1); }
            ;

FunctionCall: Identifier '(' ')' ';' {
                            Function *func = module->getFunction((char*)$2);
                            if (func == nullptr) {
                                FunctionType *funcType = FunctionType::get(builder->getVoidTy(), false);
                                func = Function::Create(funcType, Function::ExternalLinkage, (char*)$2, module);
                            }
                            builder->CreateCall(func);
                        }
            ;

IfStatement: IfToken Expression '{' {
                            std::string if_id = genId();
                            std::string begin_label = "if_begin_" + if_id;
                            std::string end_label = "if_end_" + if_id;
                            BBMap.insert({begin_label, BasicBlock::Create(context, begin_label, curFunc)});
                            BBMap.insert({end_label, BasicBlock::Create(context, end_label, curFunc)});
                            NestedIf.emplace_back(begin_label, end_label);

                            Value *cond = builder->CreateICmpNE($2, builder->getInt32(0));
                            builder->CreateCondBr(cond, BBMap[begin_label], BBMap[end_label]);
                            builder->SetInsertPoint(BBMap[begin_label]);
                        } Statements '}' {
                            if_t if_data = NestedIf.back();
                            NestedIf.pop_back();
                            builder->CreateBr(BBMap[if_data.end_label]);
                            builder->SetInsertPoint(BBMap[if_data.end_label]);
                        }
            ;

LoopStatement: LoopToken '{' {
                            std::string if_id = genId();
                            std::string begin_label = "loop_begin_" + if_id;
                            std::string end_label = "loop_end_" + if_id;
                            BBMap.insert({begin_label, BasicBlock::Create(context, begin_label, curFunc)});
                            BBMap.insert({end_label, BasicBlock::Create(context, end_label, curFunc)});
                            NestedLoop.emplace_back(begin_label, end_label);

                            builder->CreateBr(BBMap[begin_label]);
                            builder->SetInsertPoint(BBMap[begin_label]);
                        } Statements '}' {
                            loop_t loop_data = NestedLoop.back();
                            NestedLoop.pop_back();
                            builder->CreateBr(BBMap[loop_data.begin_label]);
                            builder->SetInsertPoint(BBMap[loop_data.end_label]);
                        }
            ;

ContinueStatement: ContinueToken IfToken Expression ';' {
                            if (NestedLoop.empty()) {
                                throw std::runtime_error("Continue outside of loop");
                            }
                            std::string tmp_id = genId();
                            std::string tmp_label = "tmp_" + tmp_id;
                            BBMap.insert({tmp_label, BasicBlock::Create(context, tmp_label, curFunc)});

                            Value *cond = builder->CreateICmpNE($3, builder->getInt32(0));
                            builder->CreateCondBr(cond, BBMap[NestedLoop.back().begin_label], BBMap[tmp_label]);
                            builder->SetInsertPoint(BBMap[tmp_label]);
                        }
            ;

BreakStatement: BreakToken IfToken Expression ';' {
                            if (NestedLoop.empty()) {
                                throw std::runtime_error("Break outside of loop");
                            }
                            std::string tmp_id = genId();
                            std::string tmp_label = "tmp_" + tmp_id;
                            BBMap.insert({tmp_label, BasicBlock::Create(context, tmp_label, curFunc)});

                            Value *cond = builder->CreateICmpNE($3, builder->getInt32(0));
                            builder->CreateCondBr(cond, BBMap[NestedLoop.back().end_label], BBMap[tmp_label]);
                            builder->SetInsertPoint(BBMap[tmp_label]);
                        }
            ;

Expression: Simple
            | Expression '!''=' Simple { $$ = builder->CreateZExt(builder->CreateICmpNE($1, $4), builder->getInt32Ty()); }
            | Expression '=''=' Simple { $$ = builder->CreateZExt(builder->CreateICmpEQ($1, $4), builder->getInt32Ty()); }
            | Expression '<'    Simple { $$ = builder->CreateZExt(builder->CreateICmpSLT($1, $3), builder->getInt32Ty()); }
            | Expression '<''=' Simple { $$ = builder->CreateZExt(builder->CreateICmpSLE($1, $4), builder->getInt32Ty()); }
            | Expression '>'    Simple { $$ = builder->CreateZExt(builder->CreateICmpSGT($1, $3), builder->getInt32Ty()); }
            | Expression '>''=' Simple { $$ = builder->CreateZExt(builder->CreateICmpSGE($1, $4), builder->getInt32Ty()); }
            ;

Simple:     Summand
            | Simple '+' Summand { $$ = builder->CreateAdd($1, $3); }
            | Simple '-' Summand { $$ = builder->CreateSub($1, $3); }
            ;

Summand:    Factor
            | Summand '*' Factor  { $$ = builder->CreateMul($1, $3); }
            | Summand '/' Factor  { $$ = builder->CreateSDiv($1, $3); }
            | Summand '%' Factor  { $$ = builder->CreateSRem($1, $3); }
            ;

Factor:     Primary { $$ = $1; }
            | '-' Primary { $$ = builder->CreateNeg($2); }
            | '(' Expression ')' { $$ =$2; }
            ;

Primary:    IntLiteral { $$ = builder->getInt32(atoi((char*)$1)); }
            | RandToken { $$ = builder->CreateCall(simRandFunc); }
            | Value { $$ = builder->CreateLoad(builder->getInt32Ty(), $1); }
            ;

Value:      Identifier  {
                            if (ValueMap.find((char*)$1) == ValueMap.end()) {
                                throw std::runtime_error(std::string("Variable '") + (char*)$1 + "' has not been declared");
                            }
                            $$ = builder->CreateConstGEP1_32(builder->getInt32Ty(), ValueMap[(char*)$1], 0);
                        }
            | Identifier '[' Expression ']' {
                            if (ValueMap.find((char*)$1) == ValueMap.end()) {
                                throw std::runtime_error(std::string("Variable '") + (char*)$1 + "' has not been declared");
                            }
                            $$ = builder->CreateInBoundsGEP(
                                TypeMap[(char*)$1], ValueMap[(char*)$1], {builder->getInt64(0), $3});
                        }
            ;

%%