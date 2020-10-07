; masm dos exe #
.286
.model small
.stack 64
.data
Max_Length db 255;Max Length string
Real_Length db ? ; Real length string
string1 db 255 dup (?) 
string2 db "input symbols ",0Dh,0Ah
string3 db 0Dh,0Ah,"$"
.code
start:  mov ax,@data
    mov ds,ax
    mov es,ax
    mov ah,9
    mov dx,offset string2
    int 21h

    mov dx,offset Max_Length
    mov ah,0Ah
    int 21h 
    
    mov cl,Real_Length
    mov ch,0
    mov bx,cx
    mov string1[bx],'$'
    mov si,offset string1
    mov di,si
B2: lodsb
    cmp al,'a'
    jb B3
    cmp al,'z'
    ja B3
    and al,11011111b
B3: stosb
    loop B2
    mov ah,9
    mov dx,offset string3
    int 21h
    mov ah,9
    mov dx,offset string1
    int 21h
    mov ah,0
    int 16h
    mov ah,4Ch
    int 21h
end start