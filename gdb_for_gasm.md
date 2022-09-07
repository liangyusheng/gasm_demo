``` shell
as -gstabs cpuid.asm -o cpuid.o
ld cpuid.o -o cpuid

gdb cpuid

```

`n(ext)  下一步`

`s(tep)  单步`

`r(un)   运行`

`info registers 显示寄存器值`

`p(rint) 打印。参数：/t 二进制; /d 十进制数; /x 十六进制数; /c 字符
	如：print $eax`

`x   输出内存值。参数：/c 字符; /d 十进制; /x 十六进制; z: 要显示的长度; /b 用于字节; /h 用于 16 位字，半字; /w 用于 32 位字
	如：x/cb32 &output`

