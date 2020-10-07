STK SEGMENT PARA STACK 'STACK'
	db 100 dup(0)
STK ENDS

DSEG SEGMENT PARA 'DATA'
	A db 1
    B db 2
DSEG ENDS

CSEG SEGMENT PARA 'CODE'
	assume CS:CSEG, DS:DSEG, SS:STK
main:
    mov ax, DSEG
	mov ds, ax

	mov AH, 8
    int 21h
    mov A, al

    mov AH, 8
    int 21h
    mov B, al

    mov bl, A
    sub bl, B
    add bl, 48
    ;int 21h
    
    mov dl, bl
    mov ah, 2
    int 21h

    mov ax, 4c00h
    int 21h
CSEG ENDS

END main