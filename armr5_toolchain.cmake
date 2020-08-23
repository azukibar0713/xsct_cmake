# ------------------
# preparation for XSDK path
# ------------------
execute_process(COMMAND which xsdk OUTPUT_VARIABLE XSDK)
get_filename_component(XSDK_PARENT ${XSDK} PATH)
get_filename_component(XSDK_PARENT ${XSDK_PARENT} PATH)
if (WIN32)
  SET(SDxHostSystemName "nt")
else (WIN32)
  SET(SDxHostSystemName "lin")
endif (WIN32)

# ------------------
# ARM5 Buiild.
#   2019.1の場合のGCCの置き場:Xilinx\SDK\2019.1\gnu\armr5\nt\gcc-arm-none-eabi\bin
# ------------------
SET (gnuPrefix1 gcc-arm-none-eabi)
SET (gnuPrefix2 arm-none-eabi)
SET (gnuArch armr5)


# sysroot
set(CMAKE_SYSROOT ${XSDK_PARENT}/gnu/${gnuArch}/${SDxHostSystemName}/${gnuPrefix1}/bin/)
set(GCC_LIB_DIR ${XSDK_PARENT}/gnu/${gnuArch}/${SDxHostSystemName}/${gnuPrefix1}/arm-none-eabi/lib)
set(GCC_ARM_DIR ${XSDK_PARENT}/gnu/${gnuArch}/${SDxHostSystemName}/${gnuPrefix1})

set(CROSS_PREFIX "armr5-none-eabi-")
set(CROSS_TOOLCHAIN_PATH ${XSDK_PARENT}/gnu/${gnuArch}/${SDxHostSystemName}/${gnuPrefix1}/bin/)
# toolchain
set(CMAKE_CROSSCOMPILING TRUE)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_C_COMPILER ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}gcc)
set(CMAKE_C_COMPILER ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}g++)
set(CMAKE_LINKER  ${CROSS_TOOLCHAIN_PAxiTH}${CROSS_PREFIX}ld)
set(CMAKE_AR      ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}ar)
set(CMAKE_RANLIB  ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}ranlib)
set(CMAKE_AS      ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}as)
set(CMAKE_NM      ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}nm)
set(CMAKE_OBJDUMP ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}objdump)


# extra compilation flags
SET(Arch_FLAGS "-mcpu=cortex-a5 -mfloat-abi=hard  -mfpu=vfpv3-d16")
SET (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall ${Arch_FLAGS}")

# ARMR5がdefineされていることはコードで確認した.
add_definitions(-DARMR5)

# Linker.
#include_directories(${CMAKE_SYSROOT}/../include/)

