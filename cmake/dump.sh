#!/bin/bash
touch log.txt
rm log.txt
touch log.txt

arm-none-eabi-objdump -D build/stm32_tst.elf >> log.txt
gedit log.txt&
