.section .data 

    clr:		.ascii "\033[H\033[2J"
    clr_len:	.long . - clr

    msg:        .ascii "Numero di frecce impostato: "
    msg_len:    .long . - msg

    frecce:     .long 0

    frecce_str: .ascii "0\n"

    msg2:       .ascii "Inserisci un numero per modificare: "
    msg2_len:   .long . - msg2

    inp:      .ascii "0000000000000000000"
    inp_len:  .long . - inp

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
    leal inp, %ecx
    movl inp_len, %edx
    int $0x80

    movl $0, %edx

    cmpb $10, (%ecx)
    je nan

    cmpb $45, (%ecx)
    je minf

checkCaratteri:
    
    cmpl inp_len, %edx 
    je trova_nz
    movb (%ecx, %edx), %al
    cmpb $10, %al
    je trova_nz
    cmpb $48, %al
    jl nan
    cmpb $57, %al
    jg nan
    incl %edx
    jmp checkCaratteri

trova_nz:
    
    movl %edx, %edi
    decl %edx

loop_zeri:
    
    decl %edx
    cmpl $-1, %edx
    je guarda_ultima
    cmpb $48, (%ecx,%edx)
    je loop_zeri
    jmp maxf

guarda_ultima:
    
    movl %edi, %edx
    decl %edx
    movb (%ecx,%edx), %al
    subb $48, %al
    
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









        

    






