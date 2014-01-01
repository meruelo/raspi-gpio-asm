/**************************************
 Main program's entry point
**************************************/
.section .init
.globl _start
_start:
mov sp, #0x8000
b main

/**************************************
 Main program's main function
**************************************/
.section .text
main:
mov r0, #4 @ GPIO to use
mov r1, #1 @ Value to set
mov r2, #0
mov r3, #0
mov r4, #0

/* Configure GPIO#r0 as OUTPUT */
push {r0, r1} @ 8-byte aligned (AAPCS)
bl set_gpio_function
pop {r0, r1}  @ 8-byte aligned (AAPCS)

/* Turn on and off the LED */
ldr r2, =pattern
mov r3, #0
change_led:
ldr r1, [r2, r3]
push {r0, r1, r2, r3} @ 8-byte aligned (AAPCS)
bl set_gpio_value
ldr r0, =0x7A120
bl wait
pop {r0, r1, r2, r3}  @ 8-byte aligned (AAPCS)
add r3, #4
cmp r3, #520
movhi r3, #0 
b change_led


.section .data
.balign 4
pattern: 
	.word 1, 1, 1, 1, 1, 0, 0 @ Start
	.word 1, 0, 1, 0, 1, 1, 1, 0, 1 @ F
	.word 0, 0, 0 @ -
	.word 1 @ E 20
	.word 0, 0, 0 @ -
	.word 1, 0, 1, 1, 1, 0, 1, 0, 1 @ L
	.word 0, 0, 0
	.word 1, 0, 1 @ I
	.word 0, 0, 0
	.word 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1 @ Z 32
	.word 0, 0, 0, 0, 0, 0, 0
	.word 1, 1, 1, 0, 1 @ N
	.word 0, 0, 0
	.word 1, 0, 1, 1, 1 @ A
	.word 0, 0, 0
	.word 1, 0, 1, 0, 1, 0, 1, 1, 1 @ V 31
	.word 0, 0, 0
	.word 1, 0, 1 @ I
	.word 0, 0, 0
	.word 1, 1, 1, 0, 1, 0, 1 @ D 16
	.word 0, 0, 0
	.word 1, 0, 1, 1, 1 @ A 8
	.word 0, 0, 0
	.word 1, 1, 1, 0, 1, 0, 1 @ D 10 + 3
	.word 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
