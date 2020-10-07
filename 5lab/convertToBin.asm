PUBLIC convertToBin

CSEG SEGMENT para PUBLIC 'CODE'
    assume CS:CSEG

    convertToBin proc
        xor cx, cx
        mov bx, 2 
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
    convertToBin endp
CSEG ends 
end