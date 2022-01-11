cmake_minimum_required(VERSION 3.5)
include(utils.cmake)

#include(arm-gcc-toolchain.cmake)

set(TARGET_NAME stm32_prj)
project(${TARGET_NAME})

enable_language(C ASM)
set(CMAKE_EXECUTABLE_SUFFIX ".elf")
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_BUILD_TYPE Debug)


message("-- Compiler ID ${CMAKE_C_COMPILER_ID}")

if(${CMAKE_C_COMPILER_ID} STREQUAL "GNU")

	SET(CMAKE_ASM_FLAGS "${CFLAGS} -x assembler-with-cpp")
	

	set(CPU_FLAGS 
		-mcpu=cortex-m3 
		-mthumb 
		-mfloat-abi=soft 
		-Og
		)
	
	set(COMPILER_FLAGS
		-Wall 
		-Wextra
		-fdata-sections 
		-ffunction-sections
		-fsigned-char
		-ffreestanding 
		-nostartfiles
		-nostdlib
		#debug flags
		#-ggdb3
		-g3
		-DDEBUG
		 ##???
		 -std=gnu11
		 -MMD -MP -MF
		)
	
	set(C_DEFS 
		-DUSE_HAL_DRIVER
		-DSTM32F103xE
		)
		
	string(REPLACE ";" " " _LINKER_CPU_FLAGS "${CPU_FLAGS}")
	set(LINKER_FILE  "${CMAKE_CURRENT_LIST_DIR}/STM32F103ZETx_FLASH.ld")
	
	string(APPEND CMAKE_EXE_LINKER_FLAGS " ${_LINKER_CPU_FLAGS}" 	     )
	string(APPEND CMAKE_EXE_LINKER_FLAGS " -T ${LINKER_FILE} "	         )
	string(APPEND CMAKE_EXE_LINKER_FLAGS " --specs=nosys.specs"	         	  )
	string(APPEND CMAKE_EXE_LINKER_FLAGS " -Wl,-Map=${TARGET_NAME}.map,--cref") # Generate map file
	#string(APPEND CMAKE_EXE_LINKER_FLAGS " -Wl,-nostartfiles,-nostdlib "	  ) # Do not use the standard system startup files when linking
	string(APPEND CMAKE_EXE_LINKER_FLAGS " -Wl,-gc-sections      	   " 	  ) # Delete unused section
	
	
#arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -Og -fmessage-length=0 -fsigned-char 
# -ffunction-sections -fdata-sections -ffreestanding -Wall -Wextra  
#-g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F103xE -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 
#-I"../include" -I"../system/include" -I"../system/include/cmsis" -I"../system/include/stm32f1-hal" 
#-std=gnu11 -MMD -MP -MF"src/write.d" -MT"src/write.o" -c -o "src/write.o" "../src/write.c"
	
	
	# https://www.opennet.ru/docs/RUS/gcc/gcc1-2.html
	# https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
	# https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html
	# https://gcc.gnu.org/onlinedocs/gnat_ugn/Compilation-options.html
	# https://gcc.gnu.org/onlinedocs/gcc/Spec-Files.html
	
	
	message("-- Comiler flags: ${CPU_FLAGS} ${COMPILER_FLAGS}")
	message("-- Linker  flags: ${CMAKE_EXE_LINKER_FLAGS}")
	
	
	
endif()

add_compile_options(${CPU_FLAGS} ${COMPILER_FLAGS} ${C_DEFS})

#set_property(SOURCE ./startup_stm32f103xe.s APPEND PROPERTY COMPILE_OPTIONS "-x" "assembler-with-cpp")

add_executable(${TARGET_NAME} 
	${CMAKE_CURRENT_LIST_DIR}/startup_stm32f103xe.s
	${CMAKE_CURRENT_LIST_DIR}/Src/main.c
	${CMAKE_CURRENT_LIST_DIR}/Src/stm32f1xx_it.c 
	${CMAKE_CURRENT_LIST_DIR}/Src/stm32f1xx_hal_msp.c 
	${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio_ex.c 
	${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim.c 
	${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim_ex.c 
	${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c 
	${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc.c 
	${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc_ex.c
	${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c
	${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_dma.c
	${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c
	${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_pwr.c
	${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash.c
	${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash_ex.c
	${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_exti.c 
	${CMAKE_CURRENT_LIST_DIR}/Src/system_stm32f1xx.c
	)
	
include_directories(
	./Inc
	./Drivers/STM32F1xx_HAL_Driver/Inc 
	./Drivers/STM32F1xx_HAL_Driver/Inc/Legacy 
	./Drivers/CMSIS/Device/ST/STM32F1xx/Include 
	./Drivers/CMSIS/Include 
	./Drivers/CMSIS/Include
)

firmware_size(${TARGET_NAME})

#
#
#
#
#
#
#
#
#
#
#set(CPU_FLAGS -mthumb -mcpu=cortex-m3 -Og -mfloat-abi=soft -g3)
##set(COMPILER_FLAGS -DUSE_FULL_ASSERT -DDEBUG -ffreestanding -ffunction-sections -fdata-sections -fsigned-char -fmessage-length=0 -fshort-enums)
#set(COMPILER_FLAGS
#    -mcpu=cortex-m3 
#    -mthumb 
#    -Og 
#    -fmessage-length=0 
#    -fsigned-char 
#    -ffunction-sections 
#    -fdata-sections 
#    -ffreestanding 
#    -Wall 
#    -Wextra 
#    -g3 
#)
#
#set(LINKER_FILE  "${CMAKE_CURRENT_LIST_DIR}/ldscripts/sections.ld")
#set(LINKER_FILE2 "${CMAKE_CURRENT_LIST_DIR}/ldscripts/mem.ld")
#
#include(utils.cmake)
#
#add_compile_options(${CPU_FLAGS} ${COMPILER_FLAGS})
#
## if("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
##     include(../../../clang_utils.cmake)
##     clang_utils_get_arm_gcc_sysroot(${ARM_GCC_C_COMPILER} ${CPU_FLAGS})
##     clang_utils_get_arm_gcc_multilib_dir(${ARM_GCC_C_COMPILER} ${CPU_FLAGS})
##     clang_utils_get_arm_gcc_lib_dir(${ARM_GCC_C_COMPILER} ${CPU_FLAGS})
##     clang_utils_get_arm_gcc_crt(${ARM_GCC_SYSROOT} ${ARM_GCC_MULTIDIR} ${ARM_GCC_LIBGCC_DIR})
##     string(APPEND CMAKE_EXE_LINKER_FLAGS
##         " -nostdlib -L${ARM_GCC_SYSROOT}/lib/${ARM_GCC_MULTIDIR} -L${ARM_GCC_LIBGCC_DIR}")
##     string(APPEND CMAKE_EXE_LINKER_FLAGS " -lgcc -lnosys -lc")
## elseif( "${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
#    
##     string(REGEX MATCH ".*\.specs.*" has_specs "${CMAKE_EXE_LINKER_FLAGS}")
##     if(NOT has_specs)
##           string(APPEND CMAKE_EXE_LINKER_FLAGS " --specs=nosys.specs")
##         # string(APPEND CMAKE_EXE_LINKER_FLAGS " --specs=nano.specs")
##     endif()
##     # set(osport_path "GCC/ARM_CM3")
## endif()
#
#string(REPLACE ";" " " _LINKER_CPU_FLAGS "${CPU_FLAGS}")
#string(APPEND CMAKE_EXE_LINKER_FLAGS " ${_LINKER_CPU_FLAGS} -Wl,--gc-sections -Xlinker" )
#string(APPEND CMAKE_EXE_LINKER_FLAGS " -T ${LINKER_FILE2} ")
#string(APPEND CMAKE_EXE_LINKER_FLAGS " -T ${LINKER_FILE} ")
#string(APPEND CMAKE_EXE_LINKER_FLAGS " -Wl,-Map=stm32_tst.map")
#string(APPEND CMAKE_EXE_LINKER_FLAGS " -nostartfiles ")
#string(APPEND CMAKE_EXE_LINKER_FLAGS " --specs=nosys.specs ")
#
##string(APPEND CMAKE_EXE_LINKER_FLAGS " -Wl,--undefined=uxTopUsedPriority")
#
## -T mem.ld -T libs.ld -T sections.ld -nostartfiles -Xlinker 
## --gc-sections -L"../ldscripts" -Wl,-Map,"ref103prj.map" 
## --specs=nano.specs -Wl,--undefined=uxTopUsedPriority
#
##-mcpu=cortex-m3 -mthumb -Og -fmessage-length=0 
##-fsigned-char -ffunction-sections -fdata-sections -ffreestanding -Wall -Wextra
##  -g3 -T mem.ld -T libs.ld -T sections.ld -nostartfiles -Xlinker --gc-sections -L"../ldscripts" -Wl,-Map,"f103_prj.map" --specs=nano.specs -o "f103_prj.elf" 
#
#message("compiler flags:")
#message(${CPU_FLAGS} ${COMPILER_FLAGS})
#
#message("linker flags:")
#message(${CMAKE_EXE_LINKER_FLAGS})
#
#message("CMAKE_C_COMPILER_ID")
#message(${CMAKE_C_COMPILER_ID})
#
#
#
#
#add_executable(stm32_tst 
#    src/initialize-hardware.c
#    src/led.c
#    src/main.c
#    src/stm32f1xx_hal_msp.c
#    src/timer.c
#    src/write.c
#    ${CRT0_OBJ} 
#    ${CRT_OBJ}
#
#)
#
#set_target_properties(stm32_tst PROPERTIES 
#    COMPILE_FLAGS " -DUSE_HAL_DRIVER -DSTM32F103xE -DHSE_VALUE=80000000"
#) 
#
#include(system/lib.cmake)
#include_directories(./include)
#
#set_target_properties(stm32_tst PROPERTIES LINK_DEPENDS "${LINKER_FILE}")
#
#
#
#firmware_size(stm32_tst)
## generate_object(stm32_tst .bin binary)
#
## if ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU" OR
##     "${CMAKE_C_COMPILER_ID}" STREQUAL "Clang" AND "${CMAKE_C_COMPILER_VERSION}" VERSION_GREATER_EQUAL "9.0")
##     generate_object(stm32_tst .hex ihex)
## endif()
