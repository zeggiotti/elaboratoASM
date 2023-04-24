.section .data
sec_normale:		.long 31536000
sec_bisestile:		.long 31622400
anni:			.long 0
anni_str:		.ascii "0000"
mesi:			.long 0
giorni:			.long 0
ore:			.long 0
minuti:			.long 0
secondi:		.long 0

.section .text
	.global year

.type year, @function
year:
	movl $13, %eax
	int $0x80
	
	addl $7200, %eax
	
	movl $2, %ecx
	movl $0, %edx

conta_anni:
	cmpl $4, %ecx
	je bisestile
	movl sec_normale, %ebx
	jmp dividi_anno

bisestile:
	movl $0, %ecx
	movl sec_bisestile, %ebx

dividi_anno:
	incl %edx
	subl %ebx, %eax
	incl %ecx
	cmpl sec_normale, %eax
	jge year
	
prep_mesi:
	addl $1970, %edx
	movl %edx, anni

	movl anni, %eax
	movl $4, %ecx
	leal anni_str, %esi
	call itoa
	leal anni_str, %ecx
	ret



.type itoa, @function
# Vuole il numero in %eax, la lunghezza in %ecx e l'indirizzo alla stringa risultato in %esi
itoa:
	
	movl $10, %ebx
	divl %ebx
	movl %edx, (%esi,%ecx)
	decl %ecx

	cmpl $0, %ecx
	jne itoa
	ret
