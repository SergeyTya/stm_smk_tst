cmake_minimum_required(VERSION 3.5)
include(utils.cmake)

set(TARGET_NAME stm32_prj)
project(${TARGET_NAME})

enable_language(C ASM)
set(CMAKE_EXECUTABLE_SUFFIX ".elf") 
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_BUILD_TYPE Debug)

#set(EXECUTABLE_OUTPUT_PATH  "${CMAKE_CURRENT_LIST_DIR}/../build_iar/exe")
#set(CMAKE_BINARY_DIR "${EXECUTABLE_OUTPUT_PATH}")

#set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}") # puts libriries and bin at the same dir
#set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")



message("-- Compiler ID ${CMAKE_C_COMPILER_ID}")


add_executable(${TARGET_NAME} $<TARGET_PROPERTY:STARTUP_FILE>)

target_sources(${TARGET_NAME}
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Src/main.c
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Src/stm32f1xx_it.c 
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Src/stm32f1xx_hal_msp.c 
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio_ex.c 
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim.c 
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim_ex.c 
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c 
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc.c 
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc_ex.c
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_dma.c
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_pwr.c
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash.c
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash_ex.c
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_exti.c 
	PRIVATE ${CMAKE_CURRENT_LIST_DIR}/Src/system_stm32f1xx.c
#	${CMAKE_CURRENT_LIST_DIR}/Src/newlib/_exit.c
#	${CMAKE_CURRENT_LIST_DIR}/Src/newlib/_sbrk.c
#	${CMAKE_CURRENT_LIST_DIR}/Src/newlib/_syscalls.c
#	${CRT0_OBJ} 
#    ${CRT_OBJ}
	
)
#
target_include_directories(${TARGET_NAME} PUBLIC
                          "${PROJECT_BINARY_DIR}"
                          )
	
include_directories(
	./Inc
	./Drivers/STM32F1xx_HAL_Driver/Inc 
	./Drivers/STM32F1xx_HAL_Driver/Inc/Legacy 
	./Drivers/CMSIS/Device/ST/STM32F1xx/Include 
	./Drivers/CMSIS/Include 
	./Drivers/CMSIS/Include
)

if(${CMAKE_C_COMPILER_ID} STREQUAL "IAR")
	
	set_target_properties(${TARGET_NAME} PROPERTIES
 			 DEVICE        STM32F103xE
  			 CPU           Cortex-M3
  			 FPU           none
  			 ARCHITECTURE  ${CMAKE_SYSTEM_PROCESSOR}
  			 LINKER_FILE    "${CMAKE_CURRENT_LIST_DIR}/startup/IAR/stm32f103xe_flash.icf"
  			 STARTUP_FILE  "${CMAKE_CURRENT_LIST_DIR}/startup/IAR/startup_stm32f103xe.s"
  			 
  			  # C-SPY-related properties
  			 DEVICE_DDF    "${TOOLKIT_DIR}/config/debugger/ST/STM32F103xE.ddf"
  			 DEVICE_DMAC   "${TOOLKIT_DIR}/config/debugger/ST/STM32F103xE.dmac" 
  			 )
  			 
	# Set the compiler flags for the "myProgram" target
	target_compile_options(${TARGET_NAME} 
	PRIVATE $<$<COMPILE_LANGUAGE:C,CXX, ASM>:--dlib_config normal> 
	PRIVATE --cpu $<TARGET_PROPERTY:CPU>
	PRIVATE	--fpu $<TARGET_PROPERTY:FPU> 
	PRIVATE -DUSE_HAL_DRIVER -DSTM32F103xE 
	)

	# Set the linker flags for the target
	target_link_options(${TARGET_NAME} PRIVATE
  # Genex evaluates if we are using the `Debug` configuration
 	$<$<CONFIG:Debug>: --no_wrap_diagnostics  --semihosting --redirect ___write=___write_buffered>
  # Create a map file from the target's ELF
  	--map $<TARGET_FILE:${TARGET_NAME}>.map
  # Set the linker script
  	--config $<TARGET_PROPERTY:LINKER_FILE>)
  	
  	# Add a custom target for `ielftool` to generate additional output
	add_custom_target(ielftool DEPENDS $<TARGET_FILE:${TARGET_NAME}>
  	COMMAND ${CMAKE_IAR_ELFTOOL}
  		--silent
  		# Genex evaluates FORMAT property to select the output format
  		--$<TARGET_PROPERTY:ielftool,FORMAT>
  		# Uses the target file as input
  		$<TARGET_FILE:${TARGET_NAME}>
  		# Name the output based on the selected format
  		$<TARGET_FILE:${TARGET_NAME}>.$<TARGET_PROPERTY:ielftool,FORMAT> )

		# Set the custom target FORMAT property
		# to select the desired output format (ihex|srec|bin)
	#	set_target_properties(ielftool PROPERTIES FORMAT ihex)
  	
 	
endif()

if(${CMAKE_C_COMPILER_ID} STREQUAL "GNU")

	SET(CMAKE_ASM_FLAGS "${CFLAGS} -x assembler-with-cpp")
	
	#target_sources(${TARGET_NAME} PRIVATE ${CMAKE_CURRENT_LIST_DIR}/startup/GNU/startup_stm32f103xe.s)
	
	set_target_properties(${TARGET_NAME} PROPERTIES
 			 DEVICE        STM32F103xE
  			 CPU           cortex-m3
  			 FPU           soft
  			 LINKER_FILE   "${CMAKE_CURRENT_LIST_DIR}/startup/GNU/STM32F103ZETx_FLASH.ld"
  			 STARTUP_FILE  "${CMAKE_CURRENT_LIST_DIR}/startup/GNU/startup_stm32f103xe.s"
  			 )
  			  
  	set(CPU_FLAGS 
		-mcpu=$<TARGET_PROPERTY:CPU> 
		-mfloat-abi=$<TARGET_PROPERTY:FPU> 
		-mthumb 
		-Og
		)
		
	target_compile_options(${TARGET_NAME} 
		PRIVATE ${CPU_FLAGS}
		PRIVATE -fdata-sections 
		PRIVATE -ffunction-sections
		PRIVATE -fsigned-char
		PRIVATE -ffreestanding 
		PRIVATE -nostartfiles
		PRIVATE -nostdlib
		PRIVATE -g3
		PRIVATE -std=gnu99
		PRIVATE -DUSE_HAL_DRIVER -DSTM32F103xE -DDEBUG
		PRIVATE -MMD -MP -MF
		)
		
	target_link_options(${TARGET_NAME} 
		PRIVATE ${CPU_FLAGS}
		PRIVATE -T $<TARGET_PROPERTY:LINKER_FILE> 
		PRIVATE --specs=nosys.specs
		PRIVATE -Wl,-Map=${TARGET_NAME}.map,--cref
		#PRIVATE -Wl,-nostartfiles,-nostdlib
		PRIVATE -Wl,-gc-sections
	 )
	 
 	# https://www.opennet.ru/docs/RUS/gcc/gcc1-2.html
	# https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
	# https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html
	# https://gcc.gnu.org/onlinedocs/gnat_ugn/Compilation-options.html
	# https://gcc.gnu.org/onlinedocs/gcc/Spec-Files.html
	
	firmware_size(${TARGET_NAME})

endif()


