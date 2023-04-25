.section .data

.section .text
    .global usermode

.type usermode, @function

usermode:
    movl -8(%esp),%ecx

    cmp %ecx,%edx

    ret

