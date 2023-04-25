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

.section .text

	.global _start
	
_start:
	
	# Refresh della console
	movl $4, %eax
	movl $1, %ebx
	leal clr, %ecx
	movl clr_len, %edx
	int $0x80
	
menu:
	
	# Stampo il menu
	movl riga, %edi
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
	
	movl %edi, %ebx
	addl %eax, %ebx

controllo_index:
	
	cmpl $1, %ebx
	jl min_index
	cmpl $6, %ebx
	jg max_index
	jmp fine_controllo_index
	
min_index:
	movl $6, %ebx
	jmp fine_controllo_index

max_index:
	movl $1, %ebx
	jmp fine_controllo_index
	
fine_controllo_index:
	movl %ebx, riga
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
	jne end
	movl $1, %eax
	jmp end
	
killprog:
	movl $25, %eax
	jmp end

else:
	movl $0, %eax

end:
	ret
	
