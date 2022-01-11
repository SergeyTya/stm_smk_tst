#!/bin/bash
touch log.txt
rm log.txt
touch log.txt

arm-none-eabi-objdump -D ../build/stm32_prj.elf >> log.txt
gedit log.txt&
