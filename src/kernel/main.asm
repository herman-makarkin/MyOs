org 0x0
bits 16

global start


%define ENDL 0x0D, 0x0A


start:
    mov si, msg_hello
    call prints

.halt:
    cli
    hlt

prints:
    push si
    push ax
    push bx

.loop:
    lodsb
    or al, al
    jz .done

    mov ah, 0x0E
    mov bh, 0
    int 0x10

    jmp .loop

.done:
    pop bx
    pop ax
    pop si
    ret

msg_hello: db 'Hello world!', ENDL, 0
