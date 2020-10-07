.MODEL TINY
.DOSSEG
.DATA
        A Db 1
        B Db 1
.CODE
.STARTUP
        
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
END