/**************************************
 Main program. Entry point
**************************************/
.section .init
.globl _start
_start:
mov sp, #0x8000
b main

.section .text
main:
mov r0, #7
mov r1, #1
mov r2, #0
mov r3, #0
mov r4, #0

/* Configure GPIO#r0 as OUTPUT */
push {r0, r1}
bl set_gpio_function
pop {r0, r1}

/* Turn on and off the LED */
change_led:
eor r1, r1, #1 @Set output value
push {r0, r1}
bl set_gpio_value

ldr r0, =0xE8480
bl wait
pop {r0, r1}
b change_led

