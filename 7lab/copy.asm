.686
.MODEL FLAT, C
.STACK

.CODE
strcopy PROC insertionPointer:dword, pointerFrom:dword, len:dword
	pushf
	mov ECX, len

	mov ESI, pointerFrom
	mov EDI, insertionPointer

	cmp ESI, EDI ; ���������� ���������, ���� �����, �� �����
	je endCopy

	mov EAX, ESI 
	add EAX, len 

	cmp EAX, EDI ; ��������� � ������ �����, ���� ����� ������, �� ������ ��������
	ja copying
	
	; ����� ��������� �������������
	; ���� � �����
	add ESI, len
	dec ESI
	add EDI, len
	dec EDI
	std ; ������������� ���� DF = 1 (�������� �����������)

copying:
	; �� ���� ���� �� ����� cx
	; �������� ���� �� ������ � ������
	rep movsb ; ������ ������� - �������� �� ������ ES:EDI ���� �� EDS:ESI

endCopy:
	popf
	ret

strcopy ENDP
END