.model small
.386
.stack 256
 
.data
matrix dw 16 DUP (?)
message1 db 10,13,"Please input your matrix: $"
message2 db 10,13,"Your matrix: $"
message3 db 10,13,"New matrix: $"
message4 db 10,13,"Your screen has been cleaned... $"
message5 db 10,13,"Sum of unpare elements: $"
kv_amount db 0
summa dw 0
 
.code
assume ds:@data, es:@data
start:
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    lea dx,message1
    mov ah,09h
    int 21h
    
    ; Ввод матрицы 4х4 с клавиатуры 
    mov cx,12 ;                      количество элементов в матрице
    mov si,0  ;                      обнулили индексный регистр для того чтобы начать с первого элемента
    
    mov bh,0
    mov dh,3
    mov dl,7
    mov di,3
    
    input_matrix:
    mov ah,02h
    int 10h
    
    mov ah,01h ;                     функция ввода символа
    int 21h ;                        вызов ДОС
    mov byte ptr [matrix+si],al
    inc si ;                         ...и передвигаемся ко следующему элементу матрицы
    inc dl
    dec di
    jnz next1
    inc dh
    mov di,3
    mov dl,7
    
next1:    
    loop input_matrix  ;            повторяем цикл до последнего элемента
; Закончили ввод с клавиатуры 
    
 
; Выводим на экран то что получилось
    lea dx,message2  ;                   вывод сообщения
    mov ah,09h
    int 21h 
    
    mov cx,12    ;  цикл по всем 16-ти элементам
    xor si,si     ;  обнулили индексный регистр чтобы начать с первого элемента
    mov bh,00
    mov dh,12
    mov bl,7
    mov di,3
output_matrix:
    mov ah,02h
    mov dl,bl
    int 10h
    
    mov ah,02h  ;                    функция вывода символа на экран
    mov dl,byte ptr [matrix+si];            используя реальный адрес
    int 21h
    inc bl
    inc si
    dec di
    jnz next
    inc dh
    mov di,3
    mov bl,7
next:    
    loop output_matrix
    ; Ввели матрицу, вывели ее на экран.
    
    ; Сумма элементов матрицы с нечетными значениями
    ; Проверка на нечетность
    mov cx,12
    mov si,0
    mov ax,[matrix+si]
unparity:
    test ax,ax
    inc si
    jnp kvadrat
    jp par
kvadrat:
    dec si
    mov ax,[matrix+si]
    add summa,ax
    mov bx,[matrix+si]
    mul bx
    mov [matrix+si],ax
    inc kv_amount ;счетчик нечетных чисел
par:
    loop unparity  
    
    
    
    mov ah,09h
    lea dx,message5
    int 21h
    lea dx,summa
    int 21h
    
    cmp kv_amount,0  ;проверяем если счетчик нечетных чисел равен нулю
    je clrscr ;то прыгаем к очистке экрана
    jg output ;а если нет то продолжаем
    
clrscr:
    mov ax,0600h
    mov bh,07
    mov cx,0000
    mov dx,184fh
    int 10h
    
    mov ah,09h
    lea dx,message4
    int 21h
    
output:
    ; Выводим на экран то что получилось
    lea dx,message3  ;                   вывод сообщения
    mov ah,09h
    int 21h 
    
    mov cx,12    ;  цикл по всем 16-ти элементам
    xor si,si     ;  обнулили индексный регистр чтобы начать с первого элемента
    mov bh,00
    mov dh,24
    mov bl,7
    mov di,3
output_matrix2:
    mov ah,02h
    mov dl,bl
    int 10h
    
    mov ah,02h  ;                    функция вывода символа на экран
    mov dl,byte ptr [matrix+si];            используя реальный адрес
    int 21h
    inc bl
    inc si
    dec di
    jnz next2
    inc dh
    mov di,3
    mov bl,7
next2:    
    loop output_matrix2    
    
exit:
    mov ax,4c00h
    int 21h
    
end start