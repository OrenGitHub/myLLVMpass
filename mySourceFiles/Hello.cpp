/************************/
/* FILE NAME: Hello.cpp */
/************************/

/***************/
/* DEFINITIONS */
/***************/
#define DEBUG_TYPE "hello"

/*****************/
/* INCLUDE FILES */
/*****************/
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"

/*************/
/* NAMESPACE */
/*************/
using namespace llvm;

/*******************/
/* PASS STATISTICS */
/*******************/
STATISTIC(HelloCounter, "Counts number of functions greeted");

/***********************/
/* ANONYMOUS NAMESPACE */
/***********************/
namespace
{
	struct Hello : public FunctionPass
	{
		/***********************/
		/* Pass identification */
		/***********************/
		static char ID;

		/***********/
		/* CTOR(S) */
		/***********/
		Hello() : FunctionPass(ID) {}

		/***********************/
		/* run On Function ... */
		/***********************/
		virtual bool runOnFunction(Function &F)
		{
			++HelloCounter;
			errs() << "Hello My World: ";
			errs().write_escaped(F.getName()) << '\n';
			errs() << "With First Input Parameter: ";

			llvm::Argument *end   = F.arg_end();
			llvm::Argument *begin = F.arg_begin();

			if (begin != end)
			{
				errs() << begin->getName() << '\n';
			}
			return false;
		}
	};
}

/***********************/
/* Pass identification */
/***********************/
char Hello::ID = 0;

/*********************/
/* Pass registration */
/*********************/
static RegisterPass<Hello> X("hello", "Hello World Pass");

namespace {
  // Hello2 - The second implementation with getAnalysisUsage implemented.
  struct Hello2 : public FunctionPass {
    static char ID; // Pass identification, replacement for typeid
    Hello2() : FunctionPass(ID) {}

    virtual bool runOnFunction(Function &F) {
      ++HelloCounter;
      errs() << "Hello World: ";
      errs().write_escaped(F.getName()) << '\n';
      return false;
    }

    // We don't modify the program, so we preserve all analyses.
    virtual void getAnalysisUsage(AnalysisUsage &AU) const {
      AU.setPreservesAll();
    }
  };
}

char Hello2::ID = 0;
static RegisterPass<Hello2>
Y("hello2", "Hello World Pass (with getAnalysisUsage implemented)");
