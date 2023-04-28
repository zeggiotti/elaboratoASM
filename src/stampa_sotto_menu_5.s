.section .data

clr:		.ascii "\033[H\033[2J"
clr_len:	.long . - clr

msg_on:        .ascii "1. Back-home: ON\n"
msg_on_len:    .long . - msg_on

msg_off:        .ascii "1. Back-home: OFF\n"
msg_off_len:    .long . - msg_off

input:      .ascii "00000"
input_len:  .long . - input

.section .text
    .global stampasottomenu5

.type stampasottomenu5, @function
stampasottomenu5:

    movl $4, %eax
    movl $1, %ebx
    leal clr, %ecx
    movl clr_len, %edx
    int $0x80

    movl $4, %eax
    movl $1, %ebx
    leal msg_on, %ecx
    movl msg_on_len, %edx
    int $0x80

    movl $3, %eax
    movl $0, %ebx
    leal input, %ecx
    movl input_len, %edx
    int $0x80

    ret
