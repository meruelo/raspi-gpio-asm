/**************************************
 Set GPIO to work as input or output
   r0 - GPIO number
   r1 - GPIO mode (see BCM2835)   
**************************************/
.globl set_gpio_function
set_gpio_function:
cmp r0, #53
cmpls r1, #7
movhi pc, lr

find_gpio_register:
mov r2, #0
subs r0, #10
addhs r2, #4
bhi find_gpio_register

add r0, #10
add r0, r0, lsl #1
lsl r1, r0

push {lr}
bl get_gpio_base_address
str r1, [r0, r2]
pop {lr}

mov pc, lr


