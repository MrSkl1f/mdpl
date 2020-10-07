EXTRN symb : byte
PUBLIC newNum

CSEG SEGMENT para PUBLIC 'CODE'
    assume CS:CSEG
    
    newNum proc
        xor di, di

        xor cx, cx
        
        readFirst:
            mov ah, 01h
            int 21h
            
            mov symb, al

            cmp symb, "-"
            je check
        
            cmp  symb, '0'
            jb   notNumFirst
            CMP  symb, '9'
            ja   notNumFirst
            jmp cycleReading
        check:
            mov di, 1
        read:
            mov ah, 01h
            int 21h
            
            mov symb, al
            cmp symb, 13
            jz endRead
        checkForSymb:
            cmp  symb, '0'
            jb   notNum
            CMP  symb, '9'
            ja   notNum
        cycleReading:
            cmp symb, 'A'
            jae charSymb
            sub symb, '0'
            
            
        continue:
            ;xor ax,ax
            mov ax, cx 
            mov bx, 16
            mul bx     ; умножаем на 16
           
            mov dl, symb
            add ax, dx  ; прибавляем к остальным
            mov cx, ax

            
            jmp read
            
        charSymb:
            sub symb, 'A'
            add symb, 10
            jmp continue

        notNumFirst:
            cmp symb, 'A'
            jb readFirst
            cmp symb, 'F'
            ja readFirst
            jmp read

        notNum:
            cmp symb, 'A'
            jb read
            cmp symb, 'F'
            ja read
            jmp cycleReading

        endRead:            
            cmp di, 1 ; если установлен флаг, то
            jnz retrn
            neg cx  
            mov bp, cx
            ret 

        retrn:
            mov bp, cx
            ret
    newNum endp
CSEG ends 
end