; Build:
; nasm -f elf32 hello.asm && \
; ld -m elf_i386 hello.o -o hello

%include "IO/stud_io.inc"

global _start

section .text
_start:
    mov eax, 0

again:
    PRINT "Hello"
    PUTCHAR 10
    inc eax
    cmp eax, 5
    jl again

    FINISH 0
