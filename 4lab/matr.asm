STK SEGMENT PARA STACK 'STACK'
	db 100 dup(0)
STK ENDS

DSEG SEGMENT WORD PUBLIC 'DATA'
	inputRow db 'Input rows: ', '$'
	inputCol db 10,13, 'Input columns: ', '$'
	mas db 81 dup (0) ;исходный массив
	rows db 1
	columns db 1
	amount dw 1
	current db 0
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, DS:DSEG, SS:STK

main:
	mov ax, DSEG
	mov ds,ax
	xor ax,ax ;обнуление ax
	
	lea dx,inputRow ; в dx кладем адрес inputRow (вычисляем адрес переменной)
	mov ah, 09h ; вывод строки в stdout
	int 21h	
	mov ah, 01 ; считать символ с эхом
	int 21h
	mov rows, al
	sub rows, 48

	lea dx,inputCol
	mov ah, 09h
	int 21h
	mov ah, 01
	int 21h
	mov columns, al
	sub columns, 48

	mov al, columns
	mov bl, rows
	mul bl

	mov cx,ax ;значение счетчика цикла в cx
	mov si,0 ;индекс начального элемента в cx
	mov amount, cx

	mov dl, 10
	mov ah, 02h
	int 21h
	mov bl, columns
	mov current, bl
inputMatrix: 
	mov ah, 01
	int 21h
	mov mas[si],al 
	dec current
	inc si 
	mov dl, ' '
	mov ah, 02h
	int 21h
	cmp current, 0
	jnz dataReset	

	mov dl, 10
	mov ah, 02h
	mov current, bl
	int 21h
	
dataReset:
	loop inputMatrix ;повторить цикл
	mov cx,amount
	mov si,0
	int 21h
	
	mov current, bl
show:
	cmp mas[si], 96
	ja Less	; если меньше
	jmp showafter
	Less:
		cmp mas[si], 123
		jb moreless
		jmp showafter
		moreless:
			cmp mas[si], 97
			je showafter
			cmp mas[si], 101
			je showafter
			cmp mas[si], 105
			je showafter
			cmp mas[si], 111
			je showafter
			cmp mas[si], 117
			je showafter
			cmp mas[si], 121
			je showafter
			
			sub mas[si], 32


showafter:
	mov dl,mas[si]
	mov ah,02h ;функция вывода значения из dl на экран
	int 21h
	mov dl, ' '
	mov ah, 02h
	int 21h
	inc si
	dec current
	cmp current, 0 ;если current != 0, то showNextLine, иначе nextStringShow
	jnz showNextLine	

	mov dl, 10
	mov current, bl
	int 21h

showNextLine:
	loop show
exit:
	mov ax,4c00h
	int 21h
CSEG ENDS
end main 
	