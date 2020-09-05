# ------------------
# 以下のエラー対策.
# ARMコンパイラをWindows環境でテストするのエラーとなってしまうのでworkすることにする.
#  The C compiler
#    "F:/Xilinx/SDK/2019.1/gnu/armr5/nt/gcc-arm-none-eabi/bin/armr5-none-eabi-gcc.exe"
#  is not able to compile a simple test program.
# ------------------
SET (CMAKE_C_COMPILER_WORKS 1)
SET (CMAKE_CXX_COMPILER_WORKS 1)

set(CROSS_PREFIX "armr5-none-eabi-")
# ------------------
# preparation for XSDK path
# ------------------

if(WIN32)
    execute_process(COMMAND where ${CROSS_PREFIX}gcc OUTPUT_VARIABLE GCC_FILE_PATH)
else()
    execute_process(COMMAND which ${CROSS_PREFIX}gcc OUTPUT_VARIABLE GCC_FILE_PATH)
endif()

get_filename_component(GCC_ARM_NONE_EABI_BIN_DIR ${GCC_FILE_PATH} PATH)
get_filename_component(GCC_ARM_NONE_EABI_DIR     ${GCC_ARM_NONE_EABI_BIN_DIR} PATH)

#set(GCC_ARM_DIR ${XSDK_PARENT}/gnu/${gnuArch}/${SDxHostSystemName}/${gnuPrefix1})

# toolchain
set(CMAKE_CROSSCOMPILING TRUE)
set(CMAKE_SYSTEM_PROCESSOR arm)


#SET(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_NAME Generic)
# ------------------
# toolchain
# ------------------
message(CMAKE_FIND_ROOT_PATH: ${GCC_ARM_NONE_EABI_BIN_DIR})
set(CMAKE_FIND_ROOT_PATH ${GCC_ARM_NONE_EABI_BIN_DIR})
message(CMAKE_FIND_ROOT_PATH: ${CMAKE_FIND_ROOT_PATH})


set(CMAKE_C_COMPILER   ${CROSS_PREFIX}gcc)
set(CMAKE_CXX_COMPILER ${CROSS_PREFIX}g++)
set(CMAKE_LINKER       ${CROSS_PREFIX}ld)
set(CMAKE_AR           ${CROSS_PREFIX}ar)
set(CMAKE_RANLIB       ${CROSS_PREFIX}ranlib)
set(CMAKE_AS           ${CROSS_PREFIX}as)
set(CMAKE_NM           ${CROSS_PREFIX}nm)
set(CMAKE_OBJDUMP      ${CROSS_PREFIX}objdump)


message(CMAKE_LINKER: ${CMAKE_LINKER})

#SET(Arch_FLAGS "-mcpu=cortex-a5 -mfloat-abi=hard  -mfpu=vfpv3-d16")
#SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall ${Arch_FLAGS}")

# SDKのコンパイラオプション.
# -DARMR5 -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-r5 -mfloat-abi=hard  -mfpu=vfpv3-d16 -I../../bsp/psu_cortexr5_0/include
#  -g : オブジェクト・ファイルにすべてのデバッグ情報を生成します.
#

# ------------------
# C flags
# ------------------
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -O0 -g3 -c -fmessage-length=0 -MT\"$@\" -mcpu=cortex-r5 -mfloat-abi=hard -mfpu=vfpv3-d16 -MM")

# 最後のMは↓が出たのでつけただけ.
# cc1.exe: error: to generate dependencies you must specify either -M or -MM



# ARMR5がdefineされていることはコードで確認した.
add_definitions(-DARMR5)

# Linker.
#include_directories(${CMAKE_SYSROOT}/../include/)

# SDKのリンカオプション
#  -mcpu=cortex-r5 -mfloat-abi=hard -mfpu=vfpv3-d16 -Wl,-T -Wl,../src/lscript.ld -L../../bsp/psu_cortexr5_0/lib

# exit.c:(.text.exit+0x2c): undefined reference to `_exit' の対策.
# https://www.it-swarm.dev/ja/gcc/exitc-%E3%80%82text-0x18%EF%BC%89%EF%BC%9Aarmnoneeabigcc%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%99%E3%82%8B%E5%A0%B4%E5%90%88%E3%81%AE%E3%80%8Cexit%E3%80%8D%E3%81%B8%E3%81%AE%E6%9C%AA%E5%AE%9A%E7%BE%A9%E3%81%AE%E5%8F%82%E7%85%A7/1041567654/
#set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} --specs=nosys.specs")
#set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -specs=nano.specs -specs=nosys.specs")



set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -mcpu=cortex-r5 -mfloat-abi=hard")
#set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -mcpu=cortex-r5 -mfloat-abi=hard -mfpu=vfpv3-d16")

# 以下メモ
# Linker
# - https://www.it-swarm.dev/ja/gcc/cmake%EF%BC%9A%E3%82%AB%E3%82%B9%E3%82%BF%E3%83%A0%E3%83%AA%E3%83%B3%E3%82%AB%E3%83%BC%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%99%E3%82%8B/968619405/
#   - リンクコマンドラインはModules/CMake {C、CXX、Fortran} Information.cmakeで設定されており、デフォルトではCMAKE_LINKERではなくcompilerを使用します
#