.model tiny 
code    segment
        assume cs:code, ds:code
        org 100h

start:
        jmp load    ; переход на нерезидентную часть
        lastHandler dd 0    ; адрес старого обработчика 
        time db ' 00:00:00 ', 0  ; шаблон для вывода времени
        loaded dw 1

convertTime  proc         ; процедура заполнения шаблона времени
        mov ah, al      ; преобразование двоично-десятичного 
        and al, 15      ; числа в регистре AL (логическое умножение)
        shr ah, 1       ; в пару ASCII символов
        shr ah, 1
        shr ah, 1
        shr ah, 1
        add al, '0'
        add ah, '0'
        mov time[bx + 1], ah  ; запись ASCII символов
        mov time[bx + 2], al
        add bx, 3
        ret                   ; возврат из процедуры
convertTime  endp          ; конец процедуры 

fillTime proc
        xor bx, bx         ; настройка BX для индексации шаблона
        mov al, ch         ; часы
        call convertTime  ; переводим число и записываем в шаблон
        mov al, cl         ; минуты
        call convertTime
        mov al, dh         ; секунды
        call convertTime
        ret
fillTime endp

videoMemorySetup proc
        mov ax, 0B800h     ; настройка AX на сегмент видеопамяти
        mov es, ax         ; запись в ES значения сегмента видеопамяти
        mov di, 142
        ret
videoMemorySetup endp


clock   proc ; процедура обработчика прерываний от таймера
        pushf ; создание в стеке структуры для IRET(сохранение флагов)
        call cs:lastHandler ; вызов старого обработчика прерываний
        push ds ; сохранение регистров
        push es
        push ax
        push bx
        push cx
        push dx
        push di
        push cs
        pop ds

        mov ah, 2  ; функция BIOS для получения текущего времени
        int 1Ah     ; прерывание BIOS

        call fillTime

        call videoMemorySetup

        xor bx,  bx         ; настройка BX для индексации шаблона
        mov ah,  14         ; цвет
        printTime:
                mov al, time[bx]
                stosw
                inc bx
                cmp time[bx], 0
                jnz printTime
        ; восстановление  регистров      
        
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
        pop es
        pop ds
        iret    ; возврат из обработчика
clock   endp

load:   
        mov ax, 351Ch ; получение адреса старого обработчика 351ch (35 функция у 1Ch)
        int 21h        ; прерываний от таймера

        cmp es:loaded, 1
        je uninstall

        mov word ptr lastHandler, bx ; сохранение смещения обработчика
        mov word ptr lastHandler + 2, es ; сохранение сегмента обработчика

        mov ax, 251Ch            ; установка адреса нашего обработчика (25 функция у 1Ch)
        mov dx, offset clock     ; указание смещения нашего обработчика
        int 21h
        
        mov dx, offset load
        int 27h
uninstall:
        push es
        push ds

        mov dx, word ptr es:lastHandler
        mov ds, word ptr es:lastHandler + 2

        mov ax,  251Ch
        int 21h

        pop ds
        pop es

        mov ah, 49h ; освободить блок распределенной памяти
        int 21h               
        mov ax, 4C00h
        int 21h
code    ends
        end start
