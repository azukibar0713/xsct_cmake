# 便利な環境変数
# https://gitlab.kitware.com/cmake/community/-/wikis/doc/cmake/Useful-Variables


# ------------------
# cmakeコマンド.
# > cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=./armr5_toolchain.cmake ..
# ------------------
message("CMAKE_CURRENT_SOURCE_DIR : " ${CMAKE_CURRENT_SOURCE_DIR})
message("CMAKE_SYSTEM_PROCESSOR   : " ${CMAKE_SYSTEM_PROCESSOR})
message("-----end message when entry-----")

cmake_minimum_required(VERSION 3.1)
project(hello_world C CXX)


#SET(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_NAME Generic)
message("CMAKE_SYSTEM_NAME    :" ${CMAKE_SYSTEM_NAME})
message(CMAKE_SYSTEM_PROCESSOR :${CMAKE_SYSTEM_PROCESSOR})
message(CMAKE_C_COMPILER : ${CMAKE_C_COMPILER})
message(CMAKE_LINKER     : ${CMAKE_C_COMPILER})

# ------------------
# Target Build
# ------------------
set(TARGET_NAME HELLOW)



add_executable(${TARGET_NAME} ./app_hello/src/freertos_hello_world.c)

find_library(LIBRARY_XIL
 NAMES xil
 HINTS ${CMAKE_CURRENT_SOURCE_DIR}/bsp/psu_cortexr5_0/lib/
)
find_library(LIBRARY_FREERTOS
 NAMES freertos
 HINTS ${CMAKE_CURRENT_SOURCE_DIR}/bsp/psu_cortexr5_0/lib/
)
message("XILINX_LIBRARY : " ${XILINX_LIBRARY})


#add_library(${TARGET_NAME} OBJECT ./app_hello/src/freertos_hello_world.c)
set_target_properties(${TARGET_NAME} PROPERTIES LINK_DEPENDS ../app_hello/src/lscript.ld)

#target_link_libraries(${TARGET_NAME} INTERFACE "armr5-none-eabi-gcc -mcpu=cortex-r5 -mfloat-abi=hard -mfpu=vfpv3-d16 -Wl,-T -Wl,../src/lscript.ld -L../../bsp0/psu_cortexr5_0/lib")


# ------------------
# Library.
# ------------------
link_directories(${CMAKE_CURRENT_SOURCE_DIR}/bsp/psu_cortexr5_0/lib/)
target_link_libraries(${TARGET_NAME}
# ${LIBRARY_FREERTOS}
# ${LIBRARY_XIL}
)


include_directories(./bsp/psu_cortexr5_0/include/)


include_directories(/cygdrive/f/Xilinx/SDK/2019.1/gnu/armr5/nt/gcc-arm-none-eabi/arm-none-eabi/include/)




