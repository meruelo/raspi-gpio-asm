/**************************************
 Main program. Entry point
**************************************/
.section .init
.globl _start
_start:
b main

.section .text
main:
mov sp, #0x8000
mov r0, #7
mov r1, #1
mov r2, #0
mov r3, #0
mov r4, #0

/* Configure GPIO#r0 as OUTPUT */
push {r0, r1}
bl setGPIO
pop {r0, r1}

/* Turn on and off the LED */
change_led:
eor r1, r1, #1 @Set output value
push {r0, r1}
bl setBit
pop {r0, r1}

mov r2, #0x3F0000
loop:
subs r2, #1
bne loop
b change_led
