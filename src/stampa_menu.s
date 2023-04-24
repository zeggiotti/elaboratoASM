.section .data

red:		.ascii "\033[36m"
red_len:	.long . - red

white:		.ascii "\033[37m"
white_len:	.long . - white

clr:		.ascii "\033[H\033[2J"
clr_len:	.long . - clr

primar:		.ascii "1. Setting automobile:"
primar_len:	.long . - primar

secondar:	.ascii "2. Data: "
secondar_len:	.long . - secondar

terzar:		.ascii "3. Ora: "
terzar_len:	.long . - terzar

quartar:	.ascii "4. Blocco automatico porte: "
quartar_len:	.long . - quartar

quintar:	.ascii "5. Back-home: "
quintar_len:	.long . - quintar

sestar:		.ascii "6. Check olio"
sestar_len:	.long . - sestar

settimar:	.ascii "7. Frecce direzione"
settimar_len:	.long . - settimar

ottavar:	.ascii "8. Reset pressione gomme"
ottavar_len:	.long . - ottavar

riga:		.long 1

new_line:	.ascii "\n"
nl_len:		.long 1

selection:	.ascii " <-"
sel_len:	.long 3

.section .text
	.global stampamenu

.type stampamenu, @function

stampamenu:
	
	
prima:	

	cmpl $1, %edi
	jne bprima

rprima:	
	movl $4, %eax
	movl $1, %ebx
	leal red, %ecx
	movl red_len, %edx
	int $0x80
	jmp fprima

bprima:
	movl $4, %eax
	movl $1, %ebx
	leal white, %ecx
	movl white_len, %edx
	int $0x80
	
fprima:
	movl $4, %eax
	movl $1, %ebx
	leal primar, %ecx
	movl primar_len, %edx
	int $0x80

seconda:
	movl $4, %eax
	movl $1, %ebx
	leal new_line, %ecx
	movl nl_len, %edx
	int $0x80

	cmpl $2, %edi
	jne bseconda

rseconda:	
	movl $4, %eax
	movl $1, %ebx
	leal red, %ecx
	movl red_len, %edx
	int $0x80
	jmp fseconda

bseconda:
	movl $4, %eax
	movl $1, %ebx
	leal white, %ecx
	movl white_len, %edx
	int $0x80
	
fseconda:
	movl $4, %eax
	movl $1, %ebx
	leal secondar, %ecx
	movl secondar_len, %edx
	int $0x80

terza:
	movl $4, %eax
	movl $1, %ebx
	leal new_line, %ecx
	movl nl_len, %edx
	int $0x80

	cmpl $3, %edi
	jne bterza

rterza:	
	movl $4, %eax
	movl $1, %ebx
	leal red, %ecx
	movl red_len, %edx
	int $0x80
	jmp fterza

bterza:
	movl $4, %eax
	movl $1, %ebx
	leal white, %ecx
	movl white_len, %edx
	int $0x80
	
fterza:
	movl $4, %eax
	movl $1, %ebx
	leal terzar, %ecx
	movl terzar_len, %edx
	int $0x80

quarta:
	movl $4, %eax
	movl $1, %ebx
	leal new_line, %ecx
	movl nl_len, %edx
	int $0x80

	cmpl $4, %edi
	jne bquarta

rquarta:	
	movl $4, %eax
	movl $1, %ebx
	leal red, %ecx
	movl red_len, %edx
	int $0x80
	jmp fquarta

bquarta:
	movl $4, %eax
	movl $1, %ebx
	leal white, %ecx
	movl white_len, %edx
	int $0x80
	
fquarta:
	movl $4, %eax
	movl $1, %ebx
	leal quartar, %ecx
	movl quartar_len, %edx
	int $0x80

quinta:
	movl $4, %eax
	movl $1, %ebx
	leal new_line, %ecx
	movl nl_len, %edx
	int $0x80

	cmpl $5, %edi
	jne bquinta

rquinta:	
	movl $4, %eax
	movl $1, %ebx
	leal red, %ecx
	movl red_len, %edx
	int $0x80
	jmp fquinta

bquinta:
	movl $4, %eax
	movl $1, %ebx
	leal white, %ecx
	movl white_len, %edx
	int $0x80
	
fquinta:
	movl $4, %eax
	movl $1, %ebx
	leal quintar, %ecx
	movl quintar_len, %edx
	int $0x80

sesta:
	movl $4, %eax
	movl $1, %ebx
	leal new_line, %ecx
	movl nl_len, %edx
	int $0x80

	cmpl $6, %edi
	jne bsesta

rsesta:	
	movl $4, %eax
	movl $1, %ebx
	leal red, %ecx
	movl red_len, %edx
	int $0x80
	jmp fsesta

bsesta:
	movl $4, %eax
	movl $1, %ebx
	leal white, %ecx
	movl white_len, %edx
	int $0x80
	
fsesta:
	movl $4, %eax
	movl $1, %ebx
	leal sestar, %ecx
	movl sestar_len, %edx
	int $0x80

end:
	movl $4, %eax
	movl $1, %ebx
	leal white, %ecx
	movl white_len, %edx
	int $0x80
	
	movl $4, %eax
	movl $1, %ebx
	leal new_line, %ecx
	movl nl_len, %edx
	int $0x80
	
	movl $4, %eax
	movl $1, %ebx
	leal new_line, %ecx
	movl nl_len, %edx
	int $0x80
	
	ret
