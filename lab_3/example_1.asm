global main
extern printf
extern scanf

section .data ;dane inicjowane waroscia
	str4: db "4", 10, 0
	str6: db "6", 10, 0
	str9: db "9", 10, 0
	str11: db "11", 10, 0
	str_default: db "inna liczba", 10, 0 ;0 -> null na koncu string
	format: db "%u", 0
	jump_table: dq def, def, def, def, c4, def, c6, def, def, c9, def, c11 
	; tablica podgladu, lackup table
	; etykiety, adresy 
	; dq -> q word
	; def (indexy, ktore beda odbierane z liczby sterujacej) -> |0 |1 | 2| 3| ... 11|

section .bss ;
	liczba resd 1	
section .text
	;scanf 2 argumenty int scanf("%d", &<adres_liczby>)
	; %d -> rdi
	; &<a_l> -> rsi
	; int -> eax
main:
	mov rdi, format ;pointer na 1 bajt format
	mov rsi, liczba ;pointer dla liczby
	xor eax, eax ;zerujemy adres
	call scanf ;wywolanie scanfa
	cmp eax, 0 ;jezeli eax jest zero, skok na koniec programu
	jz program_end

	mov eax,[liczba] ;operator wyluskania, odczytaj z pamieci, inta
	
	;obsulga przypadku wiekszego niz 11
	cmp eax, 11
	ja def ;adres instrukcj defaultowaej
	jmp [jump_table + 8*eax] 
	;[] - odczytaj element, ktory jest etykieta
	;skok bezwarunkowy, 8-> osmio bitowa struktura
	
	c4:
		mov rdi, str4
		jmp brk
	c6:
		mov rdi, str6
		jmp brk
	c9:
		mov rdi, str9
		jmp brk
	c11:
		mov rdi, str11
		jmp brk
	def:
		mov rdi, str_default

	brk:
		xor eax, eax
		call printf
		jmp main

	program_end:
		ret


	;printf 
	;rdi
	;eax
	;call printf
