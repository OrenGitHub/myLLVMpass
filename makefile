###############
# DIRECTORIES #
###############
BASEDIR        = /home/oren/GIT/myLLVMpass
PASS_DIR       = ${BASEDIR}/mySourceFiles
LLVM_DIR       = ${BASEDIR}/llvm-3.4.2
LLVM_SRC_DIR   = ${LLVM_DIR}/llvm
LLVM_BUILD_DIR = ${LLVM_DIR}/build
INPUT_DIR      = ${BASEDIR}/myInputFiles
OUTPUT_DIR     = ${BASEDIR}/myOutputFiles

#########
# FILES #
#########
OPT           = ${LLVM_DIR}/bulid/bin/opt
LLVM_DIS      = ${LLVM_DIR}/bulid/bin/llvm-dis
PASS_SRC_FILE = ${PASS_DIR}/Hello.cpp
PASS_OBJ_FILE = ${LLVM_DIR}/build/lib/LLVMHello.so
INPUT_FILE    = ${INPUT_DIR}/libosip

###############
# DEFINITIONS #
###############
PASS_NAME = -hello

.PHONY: all
all:
	@clear
	@setterm -term linux -fore blue
	@echo "********************************************"
	@echo "*                                          *"
	@echo "* [0] Copy my pass to llvm source tree ... *"
	@echo "*                                          *"
	@echo "********************************************"
	@setterm -term linux -fore white
	cp ${PASS_SRC_FILE} ${LLVM_SRC_DIR}/lib/Transforms
	@setterm -term linux -fore blue
	@echo "******************************************"
	@echo "*                                        *"
	@echo "* [1] Build pass in llvm source tree ... *"
	@echo "*                                        *"
	@echo "******************************************"
	@setterm -term linux -fore white
	cd ${LLVM_BUILD_DIR} && make -j
	@setterm -term linux -fore blue
	@echo "***************************"
	@echo "*                         *"
	@echo "* [2] Back to our dir ... *"
	@echo "*                         *"
	@echo "***************************"
	@setterm -term linux -fore white
	cd ${BASEDIR}
	@setterm -term linux -fore blue
	@echo "*************************"
	@echo "*                       *"
	@echo "* [3] Run pass with opt *"
	@echo "*                       *"
	@echo "*************************"
	@setterm -term linux -fore white
	${OPT} -load ${PASS} ${PASS_NAME} < ${INPUT_FILE}.bc > ${OUTPUT_DIR}/Output.txt
	@setterm -term linux -fore blue
	@echo "***************************************************************"
	@echo "*                                                             *"
	@echo "* [4] Make a human readable *.ll version of the bitcode input *"
	@echo "*                                                             *"
	@echo "***************************************************************"
	@setterm -term linux -fore white
	${LLVM_DIS} -o=  \
	${INPUT_FILE}.ll \
	${INPUT_FILE}.bc    

