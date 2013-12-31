/**************************************
 Timer function via sys timer of raspi
   r0 - Time to wait (in cycles)
**************************************/
.globl wait
wait:
mov r3, r0 @ Copy time to wait to r3
push {lr}
bl get_sys_timer_base_address
pop {lr}

ldr r1, [r0, #4] @ Read CLO register
mov r2, r1 @ Put initial counter value into r2

/* Loop until time passes */
loop:
sub r4, r1, r2 @ Now r4 stores time ellapsed
cmp r3, r4
ldrhi r1, [r0, #4]
bhi loop

mov pc, lr @ Exit 
