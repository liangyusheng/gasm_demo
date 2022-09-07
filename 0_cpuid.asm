    .file   "cpuid.asm"
    .text
    .type   main, @function
    
    .section .data
    output:
        .ascii "The processor Vendor ID is 'xxxxxxxxxxxx'\n" # 声明字符串，其起始内存位置由标签 output 指示。x 作为占位符。
    .section .text
    .globl main

main:
    movq    %rsp, %rbp
    movl    %esp, %ebp
    # 将 0 放在 EAX 寄存器，执行 cpuid 指令后，处理器会把厂商 ID 字符串返回到 EBX, EDX, ECX 中
    # EBX, EDX, ECX 各占 4 个字节的信息
    movl    $0, %eax
    cpuid   
    # cpuid 指令在 EBX, ECX, EDX 寄存器中生成关于处理器的不同信息。
    # EAX = 0 厂商 ID 字符串和支持的最大 CPUID 选项值。
    # EAX = 1 处理器类型、系列、型号、分步信息。
    # EAX = 2 处理器缓存配置
    # EAX = 3 序列号
    # EAX = 4 缓存配置（线程数量、核心数量、物理属性）
    # EAX = 5 监视信息
    # EAX = 80000000h 扩展的厂商 ID 字符换和支持级别。
    # EAX = 80000001h 扩展的处理器类型、系列、型号和分步信息。
    # EAX = 80000002h ~ 80000004h 扩展的处理器名称字符串。
    
    movl    $output, %edi
    movl    %ebx, 28(%edi) # 28 是 xxxxxxxxxxxx 的起始地址
    movl    %edx, 32(%edi) # 28 + 4 = edx 的 4 个字节
    movl    %ecx, 36(%edi) # 28 + 4 + 4 = ecx 的 4 个字节
    
    # Linux 的 write 系统调用，把字节写入文件，参数如下：
    # eax 包含系统调用值
    # ebx 文件描述符
    # exc 文件开头
    # edx 字符串长度
    
    movl    $4, %eax
    movl    $1, %ebx    # 1 = stdout
    movl    $output, %ecx
    movl    $42, %edx
    int     $0x80       # Linux systemcall
    
    movl    $1, %eax    # 退出的系统调用函数
    movl    $0, %ebx    # 返回值
    int     $0x80

# as cpuid.asm -o cpuid.o
# ld cpuid.o -o cpuid
# ./cpuid
# The processor Vendor ID is 'GenuineIntel'

