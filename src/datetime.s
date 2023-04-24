.section .data
sec_normale:		.long 31536000
sec_bisestile:		.long 31622400
anni:			.long 0
anni_str:		.ascii "0000"
mesi:			.long 0
mesi_str:		.ascii "00"
giorni:			.long 0
giorni_str:		.ascii "00"
ore:			.long 0
ore_str:		.ascii "00"
minuti:			.long 0
minuti_str:		.ascii "00"
secondi:		.long 0
secondi_str:		.ascii "00"
dt_str:			.ascii "00/00/0000 00:00:00"

epoch:			.long 0

.section .text
	.global datetime

.type datetime, @function

datetime:
	movl $1682502503, %eax
	movl $13, %eax
	leal epoch, %ebx
	int $0x80
	
	
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
	jge conta_anni
	
prep_mesi:
	addl $1970, %edx
	movl %edx, anni
	movl $1, %edx
	
conf_mesi:
	cmpl $1, %edx
	je trentuno
	cmpl $2, %edx
	je ventotto
	cmpl $3, %edx
	je trentuno
	cmpl $4, %edx
	je trenta
	cmpl $5, %edx
	je trentuno
	cmpl $6, %edx
	je trenta
	cmpl $7, %edx
	je trentuno
	cmpl $8, %edx
	je trentuno
	cmpl $9, %edx
	je trenta
	cmpl $10, %edx
	je trentuno
	cmpl $11, %edx
	je trenta
	cmpl $12, %edx
	je trentuno
	
trentuno:
	cmpl $2678400, %eax
	jl fine_mesi
	subl $2678400, %eax
	incl %edx
	jmp conf_mesi

trenta:
	cmpl $2592000, %eax
	jl fine_mesi
	subl $2592000, %eax
	incl %edx
	jmp conf_mesi

ventotto:
	cmpl $2419200, %eax
	jl fine_mesi
	subl $2419200, %eax
	incl %edx
	jmp conf_mesi
	
fine_mesi:
	movl %edx, mesi
	movl $0, %edx
	movl $86400, %ebx
	divl %ebx
	addl $1, %eax
	movl %eax, giorni
	movl %edx, %eax
	movl $0, %edx
	movl $3600, %ebx
	divl %ebx
	addl $2, %eax
	movl %eax, ore
	movl %edx, %eax
	movl $0, %edx
	movl $60, %ebx
	divl %ebx
	movl %eax, minuti
	movl %edx, secondi
	
to_ascii:
	movl giorni, %eax
	movl $2, %ecx
	leal giorni_str, %esi
	call itoa
	
	leal dt_str, %edx
	leal giorni_str, %eax
	movb (%eax), %bl
	movb 1(%eax), %bh
	movb %bl, (%edx)
	movb %bh, 1(%edx)
	
	movl mesi, %eax
	movl $2, %ecx
	leal mesi_str, %esi
	call itoa
	
	leal dt_str, %edx
	leal mesi_str, %eax
	movb (%eax), %bl
	movb 1(%eax), %bh
	movb %bl, 3(%edx)
	movb %bh, 4(%edx)
	
	movl anni, %eax
	movl $4, %ecx
	leal anni_str, %esi
	call itoa
	
	leal dt_str, %edx
	leal anni_str, %eax
	movb (%eax), %bl
	movb 1(%eax), %bh
	movb 2(%eax), %cl
	movb 3(%eax), %ch
	movb %bl, 6(%edx)
	movb %bh, 7(%edx)
	movb %cl, 8(%edx)
	movb %ch, 9(%edx)
	
	movl ore, %eax
	movl $2, %ecx
	leal ore_str, %esi
	call itoa
	
	leal dt_str, %edx
	leal ore_str, %eax
	movb (%eax), %bl
	movb 1(%eax), %bh
	movb %bl, 11(%edx)
	movb %bh, 12(%edx)
	
	movl minuti, %eax
	movl $2, %ecx
	leal minuti_str, %esi
	call itoa
	
	leal dt_str, %edx
	leal minuti_str, %eax
	movb (%eax), %bl
	movb 1(%eax), %bh
	movb %bl, 14(%edx)
	movb %bh, 15(%edx)
	
	movl secondi, %eax
	movl $2, %ecx
	leal secondi_str, %esi
	call itoa
	
	leal dt_str, %edx
	leal secondi_str, %eax
	movb (%eax), %bl
	movb 1(%eax), %bh
	movb %bl, 17(%edx)
	movb %bh, 18(%edx)
	
	leal dt_str, %esi
	
	ret
	
.type itoa, @function
# Vuole il numero in %eax, la lunghezza in %ecx e l'indirizzo alla stringa risultato in %esi
itoa:
	
	decl %ecx
	movl $10, %ebx
	divb %bl
	addb $48, %ah
	movb %ah, (%esi,%ecx)
	movb $0, %ah
	cmpl $0, %ecx
	jne itoa
	ret
