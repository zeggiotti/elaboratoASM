.section .data 

    clr:		.ascii "\033[H\033[2J"
    clr_len:	.long . - clr

    msg:        .ascii "Numero di frecce impostato: "
    msg_len:    .long . - msg

    frecce:     .long 0

    frecce_str: .ascii "0\n"

    msg2:       .ascii "Inserisci un numero per modificare: "
    msg2_len:   .long . - msg2

    input:      .ascii "00"

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
    movl $2, %edx
    int $0x80

    movl $0, %edx

contaCaratteri:
    
    cmpl $2, %edx 
    je fineConta
    movb (%ecx, %edx), %al
    cmpb $10, %al
    je fineConta
    cmpb $48, %al
    jl nan
    cmpb $57, %al
    jg nan
    incl %edx

fineConta:

    movl $0, %eax
    movl $1, %ebx
    movl $0, %edi

atoi:

    decl %edx
    movb (%ecx, %edx), %al
    subb $48, %al
    mulb %bl
    addl %eax, %edi
    movl $0, %eax
    movl $10, %ebx
    cmpl $0, %edx
    je fine_atoi
    jmp atoi

fine_atoi:

    movl %edi, %eax
    cmpl $5, %eax
    jg maxf
    cmpl $2, %eax
    jl minf
    jmp fParse

maxf:

    movl $5, %eax
    jmp fParse

minf:

    movl $2, %eax
    jmp fParse 

nan:
    movl frecce, %eax

fParse:

    ret









        

    






