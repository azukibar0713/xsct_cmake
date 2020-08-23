# ------------------
# 前提.
# - xsdkにpathが通っていること(インストールフォルダ/SDK/2019.1/bin/)
#   which xsdk を使ってpathを取得するため.
# ex.
#  export PATH=/cygdrive/f/Xilinx/SDK/2019.1/bin:$PATH
#  export PATH=/cygdrive/f/Xilinx/SDK/2019.1/gnu/armr5/nt/gcc-arm-none-eabi/bin:$PATH
# ------------------
# Windows上でのcmake
#  > cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=../armr5_toolchain.cmake ..
# ------------------
cmake_minimum_required(VERSION 3.1)
project(hello_world C CXX)


# ------------------
# Target Build
# ------------------
set(TARGET_NAME HELLOW)


add_library(${TARGET_NAME} OBJECT ./app_hello/src/freertos_hello_world.c)
set_target_properties(${TARGET_NAME} PROPERTIES LINK_DEPENDS ../app_hello/src/lscript.ld)

#target_link_libraries(${TARGET_NAME} INTERFACE "armr5-none-eabi-gcc -mcpu=cortex-r5 -mfloat-abi=hard -mfpu=vfpv3-d16 -Wl,-T -Wl,../src/lscript.ld -L../../bsp0/psu_cortexr5_0/lib")


# Link
# 現状 .a でなく .lib を参照しようとしてエラーになる.
#link_directories(./bsp/psu_cortexr5_0/lib/)
#target_link_libraries(${TARGET_NAME}
# ${GCC_ARM_DIR}/lib/gcc/arm-none-eabi/8.2.0/libgcc
# ${GCC_LIB_DIR}/libc
# libfreertos.a
# ../bsp0/psu_cortexr5_0/lib/libfreertos.a
# ../bsp0/psu_cortexr5_0/lib/libxil
#)


include_directories(./bsp/psu_cortexr5_0/include/)



# /armr5/nt/gcc-arm-none-eabi/lib/gcc/arm-none-eabi/8.2.0/libgcc.a

