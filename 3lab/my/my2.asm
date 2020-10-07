EXTRN X: byte
EXTRN exit: far

SS1 SEGMENT para STACK 'STACK'
        db 100 dup(0)
SS1 ENDS

SC1 SEGMENT para public 'CODE'
    assume CS:SC1
main:
        mov AH, 8
        int 21h

        mov X, AL

    jmp exit
SC1 ENDS
END main