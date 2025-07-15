        .section .text
        .globl  _start
        .equ    UART_BASE, 0xF0000000
_start: 
        la      t0, msg
print_loop:
        lbu     t1, 0(t0)
        beqz    t1,  print_loop 
        lui     t2,  %hi(UART_BASE)
        addi    t2,  t2, %lo(UART_BASE)
        sw      t1, 0(t2)
        addi    t0, t0, 1
        j       print_loop
        .section .rodata
msg:    .asciz "BootROM OK\r\n"
