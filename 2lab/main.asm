StkSeg  SEGMENT PARA STACK 'STACK'
        DB      200h DUP (?) 
StkSeg  ENDS 
; 
DataS   SEGMENT WORD 'DATA' 
HiMsg   DB  13
        DB 10
        DB 'Hi!'
        DB '$'
HelloMessage    DB   13                ;курсор поместить в нач. строки
                DB   10                ;перевести курсор на нов. строку                 
                DB   'Hello, world !'  ;текст сообщения                 
                DB   '$'               ;ограничитель для функции DOS 
DataS   ENDS 
; 
Code    SEGMENT WORD 'CODE'
        ASSUME  CS:Code, DS:DataS

DispMsg:
        mov CX,3
        mov   AX,DataS                 ;загрузка в AX адреса сегмента данных         
        mov   DS,AX                    ;установка DS         
        mov   DX,OFFSET HelloMessage   ;DS:DX - адрес строки               
        my:            
                mov   AH,9                     ;АН=09h выдать на дисплей строку         
                int   21h                      ;вызов  функции DO       
                mov   AH,7                     ;АН=07h ввести символ без эха
                INT   21h                      ;вызов  функции DOS
                Loop my     
        mov   AH,4Ch                   ;АН=4Ch завершить процесс         
        int   21h                      ;вызов  функции DOS 
Code    ENDS         
	END   DispMsg