# Set SDK workspace.
setws ./
#
catch {
    createhw -name hw -hwspec ./hdf/ultra96.hdf
}
#
catch {
    createbsp -name bsp -hwproject hw -proc psu_cortexr5_0 -os freertos10_xilinx
}
#
configbsp -bsp bsp stdin psu_uart_1;# 標準入力をuart1にする（ultra96用の設定）.
configbsp -bsp bsp stdout psu_uart_1;# 標準出力をuart1にする（ultra96用の設定）.
updatemss -mss bsp/system.mss;# configbspしたら必要.
regenbsp -bsp bsp;# configbspしたら必要.

#
catch {
    createlib -name led_driver -type static -proc psu_cortexr5 -os freertos10_xilinx -lang c ;# 既存のフォルダと同じ名前はNG.
}

catch {
    # Empty
    #createapp -name app_hello -app {Empty Application} -bsp bsp -hwproject hw -proc psu_cortexr5_0 -os freertos10_xilinx -lang c
    # Hello World
    createapp -name app_hello -app {Empty Application} -bsp bsp -hwproject hw -proc psu_cortexr5_0 -os freertos10_xilinx -lang c
}

# app config
#   https://www.xilinx.com/html_docs/xilinx2018_1/SDK_Doc/xsct/sdk/reference_sdk_configapp.html
configapp -app app_hello -add define-compiler-symbols MY_DEBUG_INFO

