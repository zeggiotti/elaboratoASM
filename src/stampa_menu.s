.section .data

red:		.ascii "\033[36m"
red_len:	.long . - red

white:		.ascii "\033[37m"
white_len:	.long . - white

clr:		.ascii "\033[H\033[2J"
clr_len:	.long . - clr

primar:		.ascii "1. Setting automobile:"
primar_len:	.long . - primar

primar_supervisor:		.ascii "1. Setting automobile: (supervisor)"
primar_supervisor_len:	.long . - primar_supervisor

secondar:	.ascii "2. Data: "
secondar_len:	.long . - secondar

terzar:		.ascii "3. Ora: "
terzar_len:	.long . - terzar

quartar:	.ascii "4. Blocco automatico porte: ON"
quartar_len:	.long . - quartar

quintar:	.ascii "5. Back-home: ON"
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

smode:		.long 0

on:		.ascii "ON"
on_len:	.long . - on

off:		.ascii "OFF"
off_len:	.long . - off

.section .text
	.global stampamenu

.type stampamenu, @function

# Stampa tutto il cruscotto, anche in funzione del tipo di utente
# @param %edi: riga su cui si sta lavorando

stampamenu:
	movl %eax, smode
	
prima:	

	cmpl $1, %edi
	jne bprima

rprima:	
	# Setta il colore evidenziato
	movl $4, %eax
	movl $1, %ebx
	leal red, %ecx
	movl red_len, %edx
	int $0x80
	jmp fprima

bprima:
	# Setta il colore bianco
	movl $4, %eax
	movl $1, %ebx
	leal white, %ecx
	movl white_len, %edx
	int $0x80
	
fprima:

	movl smode, %eax
	cmpl $0, %eax
	jne fprima_sv 
	# Stampa la prima riga
	movl $4, %eax
	movl $1, %ebx
	leal primar, %ecx
	movl primar_len, %edx
	int $0x80
	jmp seconda

fprima_sv:
	movl $4, %eax
	movl $1, %ebx
	leal primar_supervisor, %ecx
	movl primar_supervisor_len, %edx
	int $0x80

seconda:
	# Ripete come per la prima riga
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
	
	call datetime
	
	movl $4, %eax
	movl $1, %ebx
	movl %esi, %ecx
	movl $10, %edx
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
	
	call datetime
	
	movl %esi, %ecx
	addl $11, %ecx
	
	movl $4, %eax
	movl $1, %ebx
	movl $8, %edx
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
	leal quartar_on, %ecx
	movl quartar_on_len, %edx
	int $0x80

fquarta_off:
	movl $4, %eax
	movl $1, %ebx
	leal quartar_off, %ecx
	movl quartar_off_len, %edx
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
	jmp fquinta_on

bquinta:
	movl $4, %eax
	movl $1, %ebx
	leal white, %ecx
	movl white_len, %edx
	int $0x80
	
fquinta_on:
	movl $4, %eax
	movl $1, %ebx
	leal quintar_on, %ecx
	movl quintar_on_len, %edx
	int $0x80

fquinta_off:
	movl $4, %eax
	movl $1, %ebx
	leal quintar_off, %ecx
	movl quintar_off_len, %edx
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

	movl smode, %eax
	cmpl $0, %eax
	je end

settima:
	movl $4, %eax
	movl $1, %ebx
	leal new_line, %ecx
	movl nl_len, %edx
	int $0x80

	cmpl $7, %edi
	jne bsettima

rsettima:	
	movl $4, %eax
	movl $1, %ebx
	leal red, %ecx
	movl red_len, %edx
	int $0x80
	jmp fsettima

bsettima:
	movl $4, %eax
	movl $1, %ebx
	leal white, %ecx
	movl white_len, %edx
	int $0x80
	
fsettima:
	movl $4, %eax
	movl $1, %ebx
	leal settimar, %ecx
	movl settimar_len, %edx
	int $0x80

ottava:
	movl $4, %eax
	movl $1, %ebx
	leal new_line, %ecx
	movl nl_len, %edx
	int $0x80

	cmpl $8, %edi
	jne bottava

rottava:	
	movl $4, %eax
	movl $1, %ebx
	leal red, %ecx
	movl red_len, %edx
	int $0x80
	jmp fottava

bottava:
	movl $4, %eax
	movl $1, %ebx
	leal white, %ecx
	movl white_len, %edx
	int $0x80
	
fottava:
	movl $4, %eax
	movl $1, %ebx
	leal ottavar, %ecx
	movl ottavar_len, %edx
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
