PUBLIC symb
EXTRN newNum: near
EXTRN convertToBin: near
EXTRN convertToOct: near

SSEG SEGMENT para STACK 'STACK'
	db 100 dup(0)
SSEG ENDS

DSEG SEGMENT para PUBLIC 'DATA'
    symb db 1
    menu           db 'Menu', 10, 13
    			db	'0) Input hex number', 10, 13
				db	'1) Output unsigned bin', 10, 13
				db	'2) Output signed octal', 10, 13
				db	'3) Exit', 10, 13, '$'
    menuManager     dw 4 dup(0)
DSEG ENDS

CSEG SEGMENT para PUBLIC 'CODE'
    assume CS:CSEG, DS:DSEG, SS:SSEG

    return:
        mov ax, 4c00h
        int 21h
    
    main:
        mov ax, DSEG
        mov ds, ax

        mov menuManager[0], newNum
        mov menuManager[2], convertToBin
        mov menuManager[4], convertToOct
        mov menuManager[6], return
        
        callMenu:
            mov ah, 02h
            mov dl,10        
            int 21h           
            mov dl,13       
            int 21h

            mov ah, 9 
            mov  DX, OFFSET menu
            int  21H

            mov  ah, 8
		    int  21H
            
            sub al, '0'
            xor ah, ah
            mov dx, 2
            mul dx
            mov si, ax
            mov ax, bp
            call menuManager[si]
            jmp callMenu
    
CSEG ends 
end main