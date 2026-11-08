includelib "kernel32.lib"

GetStdHandle PROTO nStdHandle: DWORD
ExitProcess PROTO uExitCode: DWORD

_DATA$00 SEGMENT PAGE 'DATA'
    msg db "Hello, World!", 0Ah, 0
    status dq 0,0
_DATA$00 ENDS

_TEXT$00 SEGMENT ALIGN(10h) 'CODE'

SysNtWriteFile proc

    mov r10, rcx
    mov eax, 08h
    syscall
    RET

SysNtWriteFile ENDP

main PROC
    sub rsp, 48h
    mov ECX, -11d
    call GetStdHandle
    mov RCX, RAX
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    lea rax, status
    mov qword ptr [rsp + 20h], rax
    lea rax, msg
    mov qword ptr [rsp + 28h], rax
    mov dword ptr [rsp + 30h], 14d
    mov qword ptr [rsp + 38h], 0
    mov qword ptr [rsp + 40h], 0

    call SysNtWriteFile
    mov ecx, 0
    call ExitProcess

main ENDP
_TEXT$00 ENDS
END