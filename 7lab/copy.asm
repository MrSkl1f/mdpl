.686
.MODEL FLAT, C
.STACK

.CODE
strcopy PROC insertionPointer:dword, pointerFrom:dword, len:dword
	pushf
	mov ECX, len

	mov ESI, pointerFrom
	mov EDI, insertionPointer

	cmp ESI, EDI ; Сравниваем указатели, если равны, то конец
	je endCopy

	mov EAX, ESI 
	add EAX, len 

	cmp EAX, EDI ; Прибавили к началу длину, если длина меньше, то просто копируем
	ja copying
	
	; иначе указатели накладываются
	; идем с конца
	add ESI, len
	dec ESI
	add EDI, len
	dec EDI
	std ; Устанавливает флаг DF = 1 (обратное направление)

copying:
	; до того пока не конец cx
	; копирует байт из одного в другой
	rep movsb ; повтор команды - записать по адресу ES:EDI байт из EDS:ESI

endCopy:
	popf
	ret

strcopy ENDP
END