.section .data

.section .text
    .global usermode

.type usermode, @function

usermode:
    movd -8(%esp),%ecx
    movd $file name 2244, %edx


    cmp %ecx,%edx
    je supervisor
    jne user

supervisor:
    ret 1
user:
    ret 0
    
