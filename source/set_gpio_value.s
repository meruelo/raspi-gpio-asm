/**************************************
Set bit (0/1) of GPIO n 
   r0 - GPIO number
   r1 - bit value            
**************************************/
.globl set_gpio_value
set_gpio_value:
/* Check values */
cmp r0, #53
cmpls r1, #1
moveq r3, #0x1C   @ Put value
movlo r3, #0x28  @ Clear value
movhi pc, lr /* Exit function */

/* Get base address */
mov r2, #0
mov r4, r0
push {lr}
bl get_gpio_base_address /* Better with LDR ?*/
pop {lr}

/* Set R0 = GPIO + FUNC s*/
add r0, r0, r3

/* Set bit to 1 */
orr r1, #1

/* Select word: BASE+FUNC+⌊r4/32⌋*4 */
mov r5, r4, lsr #5 
lsl r5, #4         
add r0, r5 @ Now r0 contains the BASE+FUNC+OFFSET

/* Set new value for GPIO n */
and r2, r4, #31    @ r2 ← r4 mod 32
mov r1, r1, lsl r2 @ r1 ← r1 << r2
str r1, [r0]
mov pc, lr
