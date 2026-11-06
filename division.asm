;Enter dividend:8 | 8
;Enter divisor: 5 | 0
;your quotient:1 | undefine!
;your remainder:3


.model small
.stack 100h
.data

dividend db "enter dividend: $"
divisor db 13,10,"enter divisor:$"
quotient db 13,10, "your quotient:$"
remainder db 13,10,"your remainder:$"
error db 13,10,"undefine!! $"


.code

main proc
    mov ax, @data
    mov ds, ax

    ;str print, load effective address
    lea dx,dividend ; str load
    mov ah, 9h; str print
    int 21h ;interrupt

    ;dividend user input
    mov ah,1h;user input
    int 21h;interrupt
    ;al= by default input taker
    mov bl, al ; bl= dividend
    ;ascii
    sub bl, 30h; decimal convert

    ;divisor
    lea dx,divisor; str load
    mov ah, 9h; str print
    int 21h ;interrupt

    ;divisor user input
    mov ah,1h;user input
    int 21h;interrupt
    ;al= by default input taker
    mov bh, al ; bl= dividend
    ;ascii
    sub bh, '0'; decimal convert

    ;quotient
    lea dx,quotient ; str load
    mov ah, 9h; str print
    int 21h ;interrupt

    ;corner case
    cmp bh, 0 ;bh==0
    je undefine ; jump if equal
    ;ascii, pattern
    ;upper, lower, case+in insen

    ;else
    mov al, bl
    xor ah, ah ;ah = remainder
    div bh ;divisor, al = quotient
    mov dl, al
    add dl, 48; ascii convert
    mov ah, 2h; char print
    int 21h; interrupt
    jmp exit


undefine: ;segment
    lea dx,error; str load
    mov ah, 9h; str print
    int 21h ;interrupt


exit:
    mov ah, 4ch
    int 21h

main endp