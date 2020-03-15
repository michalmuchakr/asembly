global main
extern printf
extern scanf

section .data ; sekcja zmiennych
	format: db "%d", 0
	string: db "max=%d min=%d", 10, 0

section .bss ; przydzielenie liczby bajtow, alokacja, stale
	table: resd 4 ; table - adres 1. el

section .text ; z kodem programu

main: ; etykieta programu
	mov ebx, 3; itteracje od 0 do 3 wlacznie

for_loop:
	mov rdi, format ; arg do do scanf, format do ktorego scanf ma zapisac
	lea rsi, [table + 4 * ebx] ; laduj adres do rejestru, obliczmy miejsce z przesuniecia bitowego
				   ; 4 * ebx - poczatek kolejnego rejestru
	xor eax, eax ; wstawiamy rejestr a rowny zero
		     ; mov eax, 0
	call scanf 
	
	; obsluga bledu
	
	cmp eax,0 ; porownaj warosc zwrocona

	jz program_end ; jump if zero

	dec ebx ; dekrementacja
	
	jns for_loop ; gdy ponizej zero


	mov esi,[table + 12] 	  ; 12 = 3 * 4 - dlugosc tablicy
	mov edx, esi 
	mov ebx, 2 		  ; licznik itteracji

search:
	mov eax,[table + 4 * ebx] ; odczyt kolejny element
	cmp eax, esi		  ; porownaj odeczytane z obecnym max
	jl less			  ; przeskocz jezeli
		mov esi, eax 	  ; bedzie przeskoczone lub nie w zaleznosci od waruku jl
	less:
		cmp eax, edx
	jg greater		  ; warunek czy przeskoczyc
		mov edx, eax
	greater:
		dec ebx
		jns search

	mov rdi, string
	xor eax, eax
	call printf

	program_end:
	ret

