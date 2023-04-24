AS_FLAGS = --32 -g
LD_FLAGS = -m elf_i386

all: bin/main

bin/main: obj/cruscotto.o obj/stampa_menu.o
	ld $(LD_FLAGS) obj/cruscotto.o obj/stampa_menu.o -o bin/main

obj/cruscotto.o: src/cruscotto.s
	as $(AS_FLAGS) src/cruscotto.s -o obj/cruscotto.o

obj/stampa_menu.o: src/stampa_menu.s
	as $(AS_FLAGS) src/stampa_menu.s -o obj/stampa_menu.o
