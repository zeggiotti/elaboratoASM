.section .data

clr:		.ascii "\033[H\033[2J"
clr_len:	.long . - clr

msg:        .ascii "1. Back-home: "
msg_len:    .long . - msg

input:      .ascii "00000"
input_len:  .long . - input

on:		.ascii "ON\n"
on_len:	.long . - on

off:		.ascii "OFF\n"
off_len:	.long . - off

on_off_mode_5: .long 1						# 0 per stato off, 1 per stato on. Riga 4 del cruscotto

.section .text
    .global stampasottomenu5

.type stampasottomenu5, @function
stampasottomenu5:

    movl %ecx, on_off_mode_5

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

quinta_on:
	cmpl $0, on_off_mode_5
	je quinta_off
	movl $4, %eax
	movl $1, %ebx
	leal on, %ecx
	movl on_len, %edx
	int $0x80
	jmp inp

quinta_off:
	movl $4, %eax
	movl $1, %ebx
	leal off, %ecx
	movl off_len, %edx
	int $0x80

inp:
    movl $3, %eax
    movl $0, %ebx
    leal input, %ecx
    movl input_len, %edx
    int $0x80

checkinput:
	cmpb $27, (%ecx)
	jne return
	cmpb $91, 1(%ecx)
	jne return
	cmpb $10, 3(%ecx)
	jne return
	
up:
	cmpb $65, 2(%ecx)
	jne down
    jmp cambia_var

	
down:
	cmpb $66, 2(%ecx)
	jne return
    jmp cambia_var

cambia_var:
    cmpl $0, on_off_mode_5
    jne metti_zero
    movl $1, on_off_mode_5
    jmp return

metti_zero:
    movl $0, on_off_mode_5

return:
    movl on_off_mode_5, %ecx 
    ret
