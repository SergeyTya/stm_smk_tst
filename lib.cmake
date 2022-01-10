set_target_properties(stm32_tst PROPERTIES 
    COMPILE_FLAGS " -DDEBUG -DUSE_HAL_DRIVER -DSTM32F103xE -DUSE_FULL_ASSERT -DHSE_VALUE=80000000"
) 


target_sources(stm32_tst
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/newlib/assert.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/newlib/exit.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/newlib/sbrk.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/newlib/startup.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/newlib/syscalls.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/cmsis/system_stm32f1xx.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/cmsis/vectors_stm32f103xe.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/cortexm/exception-handlers.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/cortexm/initialize-hardware.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/cortexm/reset-hardware.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/diag/trace.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/diag/trace-impl.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_adc.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_adc_ex.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_can.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_cec.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_cortex.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_crc.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_dac.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_dac_ex.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_dma.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_eth.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_exti.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_flash.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_flash_ex.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_gpio.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_gpio_ex.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_hcd.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_i2c.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_i2s.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_irda.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_iwdg.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_mmc.c
#PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_msp_template.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_nand.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_nor.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_pccard.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_pcd.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_pcd_ex.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_pwr.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_rcc.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_rcc_ex.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_rtc.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_rtc_ex.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_sd.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_smartcard.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_spi.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_sram.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_tim.c
#PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_timebase_rtc_alarm_template.c
#PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_timebase_tim_template.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_tim_ex.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_uart.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_usart.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_hal_wwdg.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_adc.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_crc.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_dac.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_dma.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_exti.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_fsmc.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_gpio.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_i2c.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_pwr.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_rcc.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_rtc.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_sdmmc.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_spi.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_tim.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_usart.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_usb.c
PUBLIC ${CMAKE_CURRENT_LIST_DIR}/src/stm32f1-hal/stm32f1xx_ll_utils.c

)


include_directories(
    ${CMAKE_CURRENT_LIST_DIR}/include
    ${CMAKE_CURRENT_LIST_DIR}/include/arm
    ${CMAKE_CURRENT_LIST_DIR}/include/cmsis
    ${CMAKE_CURRENT_LIST_DIR}/include/cortexm
    ${CMAKE_CURRENT_LIST_DIR}/include/diag
    ${CMAKE_CURRENT_LIST_DIR}/include/stm32f1-hal
)
