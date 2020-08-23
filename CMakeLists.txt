# ------------------
# 前提.
# - xsdkにpathが通っていること(インストールフォルダ/SDK/2019.1/bin/)
#   which xsdk を使ってpathを取得するため.
# ------------------
# Windows上でのcmake
#  > cmake -G "Unix Makefiles" -DSDxArch=armr5 ..
# ------------------
cmake_minimum_required(VERSION 3.1)
project(hello_world C)

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
if (${SDxArch} STREQUAL "armr5")
  SET (gnuPrefix1 gcc-arm-none-eabi)
  SET (gnuPrefix2 armr5-none-eabi)
  SET (gnuArch armr5)


  # sysroot
  set(CMAKE_SYSROOT ${XSDK_PARENT}/gnu/${gnuArch}/${SDxHostSystemName}/${gnuPrefix1}/bin/)
  set(GCC_LIB_DIR ${XSDK_PARENT}/gnu/${gnuArch}/${SDxHostSystemName}/${gnuPrefix1}/arm-none-eabi/lib)
  set(GCC_ARM_DIR ${XSDK_PARENT}/gnu/${gnuArch}/${SDxHostSystemName}/${gnuPrefix1})

  set(CROSS_PREFIX "armr5-none-eabi-")
  set(CROSS_TOOLCHAIN_PATH ${XSDK_PARENT}/gnu/${gnuArch}/${SDxHostSystemName}/${gnuPrefix1}/bin/)
  # toolchain
  # FreeRTOSはないのでコメントアウト.
  set(CMAKE_CROSSCOMPILING TRUE)
  set(CMAKE_SYSTEM_NAME Generic)
  set(CMAKE_SYSTEM_PROCESSOR arm)
  set(CMAKE_C_COMPILER ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}gcc)
  #set(CMAKE_LINKER ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}gcc)
  set(CMAKE_LINKER  ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}ld)
  set(CMAKE_AR      ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}ar)
  set(CMAKE_RANLIB  ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}ranlib)
  set(CMAKE_AS      ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}as)
  set(CMAKE_NM      ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}nm)
  set(CMAKE_OBJDUMP ${CROSS_TOOLCHAIN_PATH}${CROSS_PREFIX}objdump)

  # extra compilation flags
  SET(Arch_FLAGS "-mcpu=cortex-a5")
  SET (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall ${Arch_FLAGS}")

  # Linker.
  #include_directories(${CMAKE_SYSROOT}/../include/)
  include_directories(./bsp/psu_cortexr5_0/include/)
endif()

# ------------------
# Target Build
# ------------------
set(TARGET_NAME HELLOW)


add_library(${TARGET_NAME} OBJECT ./app_hello/src/freertos_hello_world.c)
#set_target_properties(${TARGET_NAME} PROPERTIES LINK_DEPENDS ../app_hello/src/lscript.ld)

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

# /armr5/nt/gcc-arm-none-eabi/lib/gcc/arm-none-eabi/8.2.0/libgcc.a

