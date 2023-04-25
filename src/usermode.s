.section .data

.section .text
    .global usermode

.type usermode, @function

usermode:
    movl 4(%esp), %eax          # Carica il numero di parametri del programma. Non si usa pop perche in cima c'è il PC e non va tolto.
    movl 12(%esp), %ebx         # Carica l'inirizzo della stringa passata come parametro. Non è a 8(%esp) perche li ce l'indirizzo del nome del programma.

    cmp %ecx,%edx

    ret

