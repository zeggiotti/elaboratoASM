AS_FLAGS = --32 -g
LD_FLAGS = -m elf_i386

all: bin/main

bin/main: obj/cruscotto.o obj/stampa_menu.o obj/datetime.o obj/usermode.o obj/cruscotto_gomme.o obj/stampa_sotto_menu_4.o obj/stampa_sotto_menu_5.o obj/cruscotto_frecce.o
	ld $(LD_FLAGS) obj/cruscotto.o obj/stampa_menu.o obj/datetime.o obj/usermode.o obj/cruscotto_gomme.o obj/stampa_sotto_menu_4.o obj/stampa_sotto_menu_5.o obj/cruscotto_frecce.o -o bin/main

obj/cruscotto.o: src/cruscotto.s
	as $(AS_FLAGS) src/cruscotto.s -o obj/cruscotto.o

obj/stampa_menu.o: src/stampa_menu.s
	as $(AS_FLAGS) src/stampa_menu.s -o obj/stampa_menu.o

obj/datetime.o: src/datetime.s
	as $(AS_FLAGS) src/datetime.s -o obj/datetime.o

obj/usermode.o: src/usermode.s
	as $(AS_FLAGS) src/usermode.s -o obj/usermode.o

obj/cruscotto_gomme.o: src/cruscotto_gomme.s
	as $(AS_FLAGS) src/cruscotto_gomme.s -o obj/cruscotto_gomme.o

obj/stampa_sotto_menu_4.o: src/stampa_sotto_menu_4.s
	as $(AS_FLAGS) src/stampa_sotto_menu_4.s -o obj/stampa_sotto_menu_4.o

obj/stampa_sotto_menu_5.o: src/stampa_sotto_menu_5.s
	as $(AS_FLAGS) src/stampa_sotto_menu_5.s -o obj/stampa_sotto_menu_5.o

obj/cruscotto_frecce.o: src/cruscotto_frecce.s
	as $(AS_FLAGS) src/cruscotto_frecce.s -o obj/cruscotto_frecce.o
