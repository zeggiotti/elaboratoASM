.section .data

.section .text
    .global usermode

.type usermode, @function

# Mette in %eax la usermode

usermode:
    movl 4(%esp), %eax          # Carica il numero di parametri del programma. Non si usa pop perche in cima c'è il PC e non va tolto.
    movl 12(%esp), %edx         # Carica l'inirizzo della stringa passata come parametro. Non è a 8(%esp) perche li ce l'indirizzo del nome del programma.
    movl $0, %ecx

    cmpl $2, %eax
    jne fine

    movl $0, %ebx
    movb (%edx,%ecx), %bl
    cmpb $50, %bl
    jne fine

    incl %ecx

    movl $0, %ebx
    movb (%edx,%ecx), %bl
    cmpb $50, %bl
    jne fine

    incl %ecx

    movl $0, %ebx
    movb (%edx,%ecx), %bl
    cmpb $52, %bl
    jne fine

    incl %ecx

    movl $0, %ebx
    movb (%edx,%ecx), %bl
    cmpb $52, %bl
    jne fine

    incl %ecx

    movl $0, %ebx
    movb (%edx,%ecx), %bl
    cmpb $0, %bl
    jne fine

    movl $1, %eax
    jmp return

fine:
    movl $0, %eax

return:
    ret
