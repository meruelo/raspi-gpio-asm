/*

*/
.globl get_sys_timer_base_address
get_sys_timer_base_address:
ldr r0,=0x20003000
mov pc, lr
