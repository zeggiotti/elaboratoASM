.section .data

clr:		.ascii "\033[H\033[2J"
clr_len:	.long . - clr

msg:        .ascii "Pressione gomme resettata\n"
msg_len:    .long . - msg

input:      .ascii "00000"
input_len:  .long . - input

.section .text
    .global cruscotto_gomme

.type cruscotto_gomme, @function
cruscotto_gomme:

    movl $4, %eax
    movl $1, %ebx
    leal clr, %ecx
    movl clr_len, %edx
    int $0x80

    movl $4, %eax
    movl $1, %ebx
    leal msg, %ecx
    movl msg_len, %edx
    int $0x80

    movl $3, %eax
    movl $0, %ebx
    leal input, %ecx
    movl input_len, %edx
    int $0x80

    ret
