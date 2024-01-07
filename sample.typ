#import "template.typ": *
#import "@preview/codelst:2.0.0":sourcecode
#show: project.with(
  anony: false,
  title: " ",
  author: "张钧玮",
  school: "计算机学院",
  id: "U202115520",
  mentor: "潘鹏",
  class: "大数据 2102 班",
  date: (2023, 11, 2)
)

= 挑战实验1 （lab1_challenge1_backtrace）
== 实验目的

打印用户程序调用栈

对以下给定应用「user/app_print_backtrace.c」,应该实现打印用户程序调用栈的功能。既从理论上推断该程序的函数调用关系应该是「main -> f1 -> f2 -> f3 -> f4 -> f5 -> f6 -> f7 -> f8」，而print_backtrace(7)的作用就是将以上用户程序的函数调用关系，从最后f8向上打印7层


#sourcecode(```bash
/*
 * Below is the given application for lab1_challenge1_backtrace.
 * This app prints all functions before calling print_backtrace().
 */

#include "user_lib.h"
#include "util/types.h"

void f8() { print_backtrace(7); }
void f7() { f8(); }
void f6() { f7(); }
void f5() { f6(); }
void f4() { f5(); }
void f3() { f4(); }
void f2() { f3(); }
void f1() { f2(); }

int main(void) {
  printu("back trace the user app in the following:\n");
  f1();
  exit(0);
  return 0;
}

```)
uer/app_print_backtrace.c代码

== 实验内容

1. 梳理用户程序的依赖和函数调用关系，定义print_backtrace函数：

从应用出发可以发现用户程序所调用的函数都在user_lib.h中定义，user_lib.c中实现，最后转换成对do_user_call函数的调用。因为应用程序中使用的print_backtrace函数还没有导入，因此需要在user_lib.h中声明print_backtrace函数，然后在user_lib.c中将函数转换成do_user_call这样的操作系统函数调用，观察其他实现的用户函数例如printu都有一个系统宏作为do_user_call的函数参数,因此设置传入参数为系统宏SYS_print_backtrace。

#sourcecode(```c
    // @lab1_challenge1 add
    int print_backtrace(int depth);
```)user/user_lib.h代码增加行
#sourcecode(```c
    // @lab1_challenge1 add
    int print_backtrace(int depth) {
    return do_user_call(SYS_print_backtrace, depth, 0, 0, 0, 0, 0, 0);
    }
```)user/user_lib.c代码增加行
2. 声明系统宏和系统调用号：
重新执行./obj/app_print_backtrace发现不再报错但是显示为未止的系统调用。这提示我们需要修改增加内核代码，使得backtrace可以正常被调用。首先需要在kernel/syscall.h中声明系统宏和系统调用号，然后在kernel/syscall.c中实现系统调用。
#sourcecode(```c
// @lab1_challenge1 add
//
// [a0]: the syscall number; [a1] ... [a7]: arguments to the syscalls.
// returns the code of success, (e.g., 0 means success, fail for otherwise)
//
long do_syscall( long a0, long a1, long a2, long a3, long a4, long a5, long a6,long a7 ) {
    switch ( a0 ) {
    case SYS_user_print:
        return sys_user_print( (const char *) a1, a2 );
    case SYS_user_exit:
        return sys_user_exit( a1 );
    case SYS_print_backtrace:
        return sys_backtrace( a1 );
    default:
        panic( "Unknown syscall %ld \n", a0 );
    }
}
```)kernel/syscall.c代码增加行
3. 参照sys_user_print函数设计sys_user_backtrace函数：
首先需要为sys_user_backtrace函数引入elf_get_funname函数，这个函数在elf.h中定义，作用是通过传入的函数地址获取函数名。
sys_user_backtrace的实现思路是通过当前进程的trapframe获取当前函数的栈指针，然后通过栈指针获取当前函数的函数地址，再通过调用elf_get_funname函数根据函数地址获取函数名。通过循环获取函数名就可以实现打印函数调用栈调用栈的功能。设计是如果遍历到mian函数返回当前函数调用栈的层数，sys_user_backtrace的正常返回值是depth。
#sourcecode(```c
    // added @lab1_challenge1
    ssize_t sys_user_backtrace( uint64 depth ) {
        int i, off;
        uint64 fun_sp = current->trapframe->regs.sp + 32;
        uint64 fun_pa = fun_sp + 8;
        i = 0;
        while ( i < depth ) {
            if ( elf_get_funname( *(uint64 *) fun_pa ) == 0 ) return i;
            fun_pa += 16;
            i++;
        }
        return i;
    }
```)kernel/syscall.c代码增加行

因为sys_user_backtrace要求只能在syscall.c内部进行调用，因此不需要再在syscall.h中进行声明，这是操作系统的保护性措施，目的在于防止用户程序直接调用系统调用。

4. elf_get_funname函数的实现
根据传入的函数地址在elf文件的符号表中通过遍历符号表查找对应函数，如果地址位于符号表的某个函数的地址范围内，则说明传入地址对应的就是这个函数，打印函数名并返回1。如果发现传入地址是main函数则返回0.
#sourcecode(```c
// added @lab1_challenge1
int elf_get_funname( uint64 ret_addr ) {
    int len_count = sym_count;
    for ( int i = 0; i < sym_count; i++ ) {

        if ( ret_addr >= symbols[ i ].st_value &&
             ret_addr < symbols[ i ].st_value + symbols[ i ].st_size ) {
            sprint( "%s\n", sym_name_pool[ i ] );
            if ( strcmp( sym_name_pool[ i ], "main" ) == 0 ) return 0;
            return 1;
        }
    }
    return 1;
}
```)elf_get_funname函数实现


== 实验调试与心得

实验的要求的知识点特别多。

在线程调用中，因为current->trapframe->regs.sp 指向的是当前进程的栈指针，通过观察sp结构可以以及使用sprint("%d\n",res)之类的工具进行打印调试知道通过sp指向地址和main函数地址差了32个字节，因此uint64 fun_sp = current->trapframe->regs.sp + 32可以获取到main函数的地址，而uint64 fun_pa = fun_sp + 8就可以获得第一次调用backtrace函数的函数的地址，然后根据这个地址依次因为栈帧的长度是16字节，+16字节遍历elf的符号表就可以正确地遍历函数的调用栈。

另外打印符号表同样是一个难点，因为我们需要知道对应函数的起始地址，而这事实上与PKE的大小端策略有关，如果是小端则起始地址是从小地址开始，如果是大端则计算出的pa的起始地址还需要增加一个偏移值才是正确的函数地址。通过阅读elf.h，发现elf_header_t里贴心地给我标了注释，PKE使用的是小端模式。

事实上关于这关存在两种思路，一种是通过追踪函数调用的栈帧来获取函数地址再在elf里面查表，一种是读取elf的Section Header Table来追踪函数。后者因为需要深入elf文件系统，我能力有限经过短暂的尝试选择了放弃，但是前者同样是一种讨巧的方法，因为栈帧的长度不是固定的，理论上需要设计算法获取栈帧的长度来遍历函数调用栈，但是我选择设计每次传入地址以后在获取函数名的函数内部对地址进行反复自增直到获取到新的函数名为止，这种方式同样实现了函数调用栈的遍历，但是不需要设计算法获取栈帧的长度，因此更加简单。最后，事实上本题栈帧的长度是固定的，因为函数的调用栈是用来存放传入参数的，而测试用的程序因为不存在参数，长度固定是16字节。所以无论是否对栈帧长度进行计算，都可以正确地遍历函数调用栈。