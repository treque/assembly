.data

.global func_s

func_s:
        movl    $0, %ecx
        jmp     .L2
.L6:
        movl    d, %edx
        movl    e, %eax
        addl    %eax, %edx
        movl    b, %eax
        subl    %eax, %edx
        movl    %edx, %eax
        movl    %eax, a
        movl    b, %eax
        leal    -1000(%eax), %edx
        movl    c, %eax
        addl    $500, %eax
        cmpl    %eax, %edx
        jge     .L3
        movl    c, %eax
        subl    $500, %eax
        movl    %eax, c
        movl    b, %edx
        movl    c, %eax
        cmpl    %eax, %edx
        jle     .L5
        movl    b, %eax
        subl    $500, %eax
        movl    %eax, b
        jmp     .L5
.L3:
        movl    b, %edx
        movl    e, %eax
        subl    %eax, %edx
        movl    %edx, %eax
        movl    %eax, b
        movl    d, %eax
        addl    $500, %eax
        movl    %eax, d
.L5:
        addl    $1, %ecx
.L2:
        cmpl    $10, %ecx
        jle     .L6
        ret
