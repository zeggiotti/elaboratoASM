.section .data

clr:		.ascii "\033[H\033[2J"
clr_len:	.long . - clr

riga:		.long 1

new_line:	.ascii "\n"
nl_len:		.long 1

selection:	.ascii " !"
sel_len:	.long 2

sel_input:	.ascii "0000"
sel_input_len:	.long 4

mode:		.long 0							# 0 per utente normale, 1 per SuperVisor

frecce:		.long 3

.section .text

	.global _start
	
_start:
	call usermode
	movl %eax, mode

	# Refresh della console
	movl $4, %eax
	movl $1, %ebx
	leal clr, %ecx
	movl clr_len, %edx
	int $0x80
	
menu:
	
	# Stampo il menu
	movl riga, %edi
	movl mode, %eax
	call stampamenu
	
	# Chiedo di spostarsi sul menu
	movl $3, %eax
	movl $0, %ebx
	leal sel_input, %ecx
	movl sel_input_len, %edx
	int $0x80
	
	# Controllo l'input messo dall'utente
	leal sel_input, %esi
	call checkinput
	
	# Se eax vale 25 il programma deve chiudersi
	cmpl $25, %eax
	je fine_prog

	cmpl $18, %eax 
	je scelta_sottomenu

	movl %edi, %ebx
	addl %eax, %ebx

# Modifica la riga corrente nel caso sia stata inserita freccia su/giu
check_riga_max:
	movl mode, %ecx
	cmpl $1, %ecx
	jne max_riga_normalUser
	movl $8, %ecx
	jmp controllo_index

max_riga_normalUser:
	movl $6, %ecx

controllo_index:
	
	cmpl $1, %ebx
	jl min_index
	cmpl %ecx, %ebx
	jg max_index
	jmp fine_controllo_index
	
min_index:
	movl %ecx, %ebx
	jmp fine_controllo_index

max_index:
	movl $1, %ebx
	jmp fine_controllo_index
	
fine_controllo_index:
	movl %ebx, riga
	jmp _start

scelta_sottomenu:
	movl riga, %eax
	cmpl $8, %eax
	jne altrimenti_1
	call cruscotto_gomme
	jmp fine_scelta

altrimenti_1:
	cmpl $4, %eax
	jne altrimenti_2
	call stampasottomenu4
	jmp fine_scelta

altrimenti_2:
	cmpl $5, %eax
	jne fine_scelta
	call stampasottomenu5
	jmp fine_scelta

fine_scelta:
	jmp _start
	
fine_prog:
	movl $1, %eax
	int $0x80

	
.type checkinput, @function
# Controlla se la freccia è su o giù, per poi spostarla nel menu
# Vuole l'indirizzo del carattere in input in %esi e produce in %eax il valore da sommare a riga (1 o -1)
checkinput:
	cmpb $48, (%esi)
	je killprog
	cmpb $27, (%esi)
	jne else
	cmpb $91, 1(%esi)
	jne else
	cmpb $10, 3(%esi)
	jne else
	
up:
	cmpb $65, 2(%esi)
	jne down
	movl $-1, %eax
	jmp end
	
down:
	cmpb $66, 2(%esi)
	jne right
	movl $1, %eax
	jmp end
	
right:
	cmpb $67, 2(%esi)
	jne else
	movl $18, %eax
	jmp end

killprog:
	movl $25, %eax
	jmp end

else:
	movl $0, %eax

end:
	ret
	
