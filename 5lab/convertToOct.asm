PUBLIC convertToOct
CSEG SEGMENT para PUBLIC 'CODE'
    assume CS:CSEG

    convertToOct proc 
        test ax, ax
        jns  notNEG
        mov  cx, ax
        mov  ah, 02h
        mov  dl, '-'
        int  21h
        mov  ax, cx
        neg  ax
        notNEG:  
            xor cx, cx
            mov bx, 8 
        convertNum:
            xor dx,dx
            div bx ; остаток от деления в dx если слово
            push dx
            inc cx
            test ax, ax
            jnz convertNum
            mov ah, 02h
        printNum:
            pop dx
            add dl, '0'
            int 21h
            loop printNum
            ret 
    convertToOct endp
CSEG ends 
end