.section .data 

    clr:		.ascii "\033[H\033[2J"
    clr_len:	.long . - clr

    msg:        .ascii "Numero di frecce impostato: "
    msg_len:    .long . - msg

    frecce:     .long 0

    frecce_str: .ascii "0\n"

    msg2:       .ascii "Inserisci un numero per modificare: "
    msg2_len:   .long . - msg2

    input:      .ascii "0000"

.section .text 

    .global cruscotto_frecce

.type cruscotto_frecce, @function

cruscotto_frecce: 

    movl %eax, frecce

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

    movl frecce, %eax
    addl $48, %eax
    leal frecce_str, %ecx
    movb %al, (%ecx)

    movl $4, %eax
    movl $1, %ebx
    movl $2, %edx
    int $0x80

    movl $4, %eax
    movl $1, %ebx
    leal msg2, %ecx
    movl msg2_len, %edx
    int $0x80

    movl $3, %eax
    movl $0, %ebx
    leal input, %ecx
    movl , %edx
    int $0x80




