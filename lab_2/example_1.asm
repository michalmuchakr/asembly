; if (esi == edi)
;	r15 = 10
; else
;	r8 = 2


je then
	mov r8, 10
	jmp end_if
then:
	mov r15, 10
end_if:
