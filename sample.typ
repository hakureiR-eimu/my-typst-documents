#import "template.typ": *
#import "@preview/codelst:2.0.1": sourcecode


#show: project.with(

)


= 打印异常代码行

== 实验目的

修改pke内核，使得程序在用户态试图读取内核态寄存器时，抛出错误并且输出触发异常的用户程序源文件名和对应代码行。正确的程序输出如下。


#block(
  width: 100%,
)[
#sourcecode[```bash
riscv-pke on  lab1_challenge2_errorline 
❯ spike ./obj/riscv-pke obj/app_errorline
In m_start, hartid:0
HTIF is available!
(Emulated) memory size: 2048 MB
Enter supervisor mode...
Application: obj/app_errorline
Application program entry point (virtual address): 0x0000000081000000
Switch to user mode...
Going to hack the system by running privilege instructions.
Runtime error at user/app_errorline.c:13
  asm volatile("csrw sscratch, 0");
Illegal instruction!
System is shutting down with exit code -1.
```]
]

#img(
  image("assets/正确的输出lab1_2.png", height: 20%),
  caption: "正确的输出lab1_challenge2",
)
#pagebreak()

== 实验内容

为了完成实验，需要执行并且完成以下的两部分内容。

①首先，需要增加对elf可执行文件的调试探查。具体来说，就是在elf.h头文件中定义，在elf.c文件中实现函数 #emph(text(black)[ elf_status load_debugline(elf_ctx \*ctx); ]),并且在elf的二进制程序加载执行函数 #emph(text(black)[void load_bincode_from_host_elf( process \*p )])中运行以加载debug段。

以下是 #emph[#text(black)[load_debugline]] 的具体代码以及思路。

#sourcecode[```C
// added @lab1_challenge2 | load debugline
elf_status load_debugline( elf_ctx *ctx ) {
    // sprint( "hello load_debugline\n");
    // sprint("%d\n",ctx);
    // claim string table header
    elf_sect_header strtab;
    // get string table header's info
    int offset;

    offset = ctx->ehdr.shoff;
    // sprint("%d\n",ctx->ehdr.version);
    // sprint( "%d\n", offset );
    // sprint( "%d\n", ctx->info );
    offset += sizeof( strtab ) * ( ctx->ehdr.shstrndx );
    // sprint( "%d\n", offset );

    // save string table header
    if ( elf_fpread( ctx, (void *) &strtab, sizeof( strtab ), offset ) !=
         sizeof( strtab ) ) {
        panic( "string table header get failed!\n" );
    }

    // save string table
    static char strtab_info[ STRTAB_MAX ];
    if ( elf_fpread( ctx, (void *) strtab_info, strtab.size, strtab.offset ) !=
         strtab.size ) {
        panic( "string table get failed!\n" );
    }
    
    // get .debug_line segment
    elf_sect_header debugseg;
    int index;
    for ( index = 0, offset = ctx->ehdr.shoff; index < ctx->ehdr.shnum;
          index++, offset += sizeof( debugseg ) ) {
        if ( elf_fpread( ctx, (void *) &debugseg, sizeof( elf_sect_header ),
                         offset ) != sizeof( elf_sect_header ) )
            panic( "debug header get failed!\n" );
        // sprint("i=%d,%s\n",i,strtab_info+debugseg.name);
        if ( strcmp( (char *) ( strtab_info + debugseg.name ),
                     ".debug_line" ) == 0 )
            break;
    }

    if ( index == ctx->ehdr.shnum ) {
        panic( "can't find debugline!\n" );
        return EL_ERR;
    }
    int i;

    // get debugline's information
    static char debugline[ DEBUGLINE_MAX ];
    if ( elf_fpread( ctx, (void *) debugline, debugseg.size,
                     debugseg.offset ) != debugseg.size )
        panic( "debugline get failed!\n" );
    make_addr_line( ctx, debugline, debugseg.size );
    return EL_OK;
}
```]

函数主要思路如下：

1.首先，从 ELF 上下文中获取字符串表头信息。这个信息包含了字符串表的偏移和大小等。

2.然后，通过上一步得到的字符串表头信息，从 ELF 文件中读取字符串表的内容，并保存到数组#emph[#text(black)[strtab_info]]中。

3.接下来，遍历 ELF 文件中的节头表，寻找名称为.debug_line的段。

4.一旦找到了.debug_line段，就从文件中读取该段的内容，保存到另一个数组中。这些内容包含调试信息，比如源代码文件名、行号等。

5.最后，调用make_addr_line函数来处理这些调试线信息将缓冲区指针传入。

6.函数返回一个表示加载调试线信息是否成功的状态，EL_OK表示成功，或者EL_ERR表示失败。

#pagebreak()


②完成对elf二进制程序的debug_line段的读取以后，接下来要做的就是抛出异常时打印出源程序名和对应代码行。

异常属于中断的一种，因此通过 #emph[mstrap.c]中定义实现并且在触发#emph[handle_illegal_instruction函数]时候执行#emph[print_error_lines函数]，就可以正确的完成需求。以下是#emph[print_error_lines函数]的具体代码以及实现。

#sourcecode[```C
static void print_error_lines() {
  // sprint("Runtime error at user/app_errorline.c:13\n  asm volatile(\"csrw sscratch, 0\");\n");

  uint64 epc = read_csr(mepc);
  addr_line* cur_line = current->line;
  int i = 0;

  //find errorline's instruction address
  for (i = 0, cur_line = current->line;i < current->line_ind && cur_line->addr != epc;++i, ++cur_line)
    {
    //sprint("i=%d,addr=%x\n",i,cur_line->addr);
    if (cur_line->addr == epc) break;
    }
  if (i == current->line_ind) panic("can't find errorline!\n");
  //sprint("find errorline,i=%d\n",i);


//find file's path and name
  char filename[FILENAME_MAX];
  //find filename
  code_file* cur_file = current->file + cur_line->file;
  char* single_name = cur_file->file;
  //find file's path
  char* file_path = (current->dir)[cur_file->dir];
  //combine path and name
  int start = strlen(file_path);
  strcpy(filename, file_path);
  filename[start] = '/';
  start++;
  strcpy(filename + start, single_name);
  sprint("Runtime error at %s:%d\n", filename, cur_line->line);

  //find error line
    //error instruction's line
  int error_line = cur_line->line;
  //open file
  spike_file_t* file = spike_file_open(filename, O_RDONLY, 0);
  if (IS_ERR_VALUE(file)) panic("open file failed!\n");
  //get file's content
  char file_detail[FILE_MAX];
  spike_file_pread(file, (void*)file_detail, sizeof(file_detail), 0);

  //fine error line's start 
  int line_start = 0;
  for (i = 1;i < error_line;i++)
    {
    //sprint("line=%d,%s\n",i,file_detail+line_start);
    while (file_detail[line_start] != '\n') line_start++;
    line_start++;
    }
  char* errorline = file_detail + line_start;
  while (*errorline != '\n') errorline++;
  *errorline = '\0';
  //print error line
  sprint("%s\n", file_detail + line_start);
  spike_file_close(file);
  }

```]

函数的主要思路如下：

1.寄存器epc是用于保存当前执行代码的地址的处理器寄存器，因此为了获得抛出错误的代码位置需要首先获得代码的地址。#emph[read_csr(mepc)]获取发生错误的代码地址。

2.遍历当前进程的代码行数组，在其中查找发生异常的指令地址对应的代码行。

3.根据进程提供信息，拼接获取代码文件的路径和文件名。

4.打开代码文件，读取文件内容。定位到错误行在文件内容中的起始位置。

5.提取错误行的内容并打印出来，同时关闭文件。
== 实验调试及心得

关于elf文件与进程函数之间的接口问题：读取elf文件的代码，找到包含调试信息的段以后，想要将其内容保存起来，有两个可以的手段。要么是用静态数组来存储debug_line段数据，那么这个数组必须足够大；也可以把debug_line直接放在程序所有需映射的段数据之后，这样可以保证有足够大的动态空间。本次挑战因为提供了方便的util函数#emph[make_addr_line]来解析.debug_line段并保存到静态数组，因此选择后者。

= 堆空间管理
== 实验目的

== 实验内容
== 实验调试及心得

// 个人理解：typst 有两种环境，代码和内容，在代码的环境中会按代码去执行，在内容环境中会解析成普通的文本，代码环境用{}表示，内容环境用[]表示，在 content 中以 \# 开头来接上一段代码，比如\#set rule，而在花括号包裹的块中调用代码就不需要 \#。


// === 标题

// 类似 Markdown 里用 \# 表示标题，typst 里用 = 表示标题，一级标题用一个 =，二级标题用两个 =，以此类推。


// 间距、字体等会自动排版。

// \#pagebreak() 函数相当于分页符，在华科的要求里，第一级标题应当分页，请手动分页。

// #pagebreak()

// = 本模板相关封装

// == 图片

// 除了排版，这个模板主要改进了图片、表格、公式的引用，编号以第x章来计算。


// 图用下面的方式来引用，img 是对 image 的包装，caption 是图片的标题。

// #img(
//   image("assets/avatar.jpeg", height: 20%),
//   caption: "我的 image 实例 1",
// ) <img1>

// 引用的话就在 img 后加上标签<label>，使用 at 来引用即可，比如@img2 就是这么引用的。

// #img(
//   image("assets/avatar.jpeg", height: 20%),
//   caption: "我的 image 实例 2",
// ) <img2>

// 引用 2-1: @img1

// == 表格

// 表格跟图片差不多，但是表格的输入要复杂一点，建议在 typst 官网学习，自由度特别高，定制化很强。

// 看看@tbl1，tbl 也是接收两个参数，一个是 table 本身，一个是标题，table 里的参数，没有字段的一律是单元格里的内容（每一个被[]）包起来的内容，在 align 为水平时横向排列，排完换行。

// #tbl(
//   table(
//     columns: (100pt, 100pt, 100pt),
//     inset: 10pt,
//     stroke: 0.7pt,
//     align: horizon,
//     [], [*Area*], [*Parameters*],
//     image("assets/avatar.jpeg", height: 10%),
//     $ pi h (D^2 - d^2) / 4 $,
//     [
//       $h$: height \
//       $D$: outer radius \
//       $d$: inner radius
//     ],
//     image("assets/avatar.jpeg", height: 10%),
//     $ sqrt(2) / 12 a^3 $,
//     [$a$: 边长]
//   ),
//   caption: "芝士样表"
// ) <tbl1>



// #tbl(
//   three_line_table(
//     (
//     ("Country List", "Country List", "Country List"),
//     ("Country Name or Area Name", "ISO ALPHA Code", "ISO ALPHA"),
//     ("Afghanistan", "AF", "AFT"),
//     ("Aland Islands", "AX", "ALA"),
//     ("Albania", "AL", "ALB"),
//     ("Algeria", "DZ", "DZA"),
//     ("American Samoa", "AS", "ASM"),
//     ("Andorra", "AD", "AND"),
//     ("Angola", "AP", "AGO"),
//   )),
//   caption: "三线表示例"
// )

// #tbl(
//   three_line_table(
//     (
//     ("Country List", "Country List", "Country List", "Country List"),
//     ("Country Name or Area Name", "ISO ALPHA 2 Code", "ISO ALPHA 3", "8"),
//     ("Afghanistan", "AF", "AFT", "7"),
//     ("Aland Islands", "AX", "ALA", "6"),
//     ("Albania", "AL", "ALB", "5"),
//     ("Algeria", "DZ", "DZA", "4"),
//     ("American Samoa", "AS", "ASM", "3"),
//     ("Andorra", "AD", "AND", "2"),
//     ("Angola", "AP", "AGO", "1"),
//   )),
//   caption: "三线表示例2"
// )


// == 公式

// 公式用两个\$包裹，但是语法跟 LaTeX 并不一样，如果有大量公式需求建议看官网教程 https://typst.app/docs/reference/math/equation/。

// 为了给公式编号，也依然需要封装，使用 equation 里包公式的方式实现，比如：

// #equation(
//   $ A = pi r^2 $,
// ) <eq1>

// 根据@eq1 ，推断出@eq2

// #equation(
//   $ x < y => x gt.eq.not y $,
// ) <eq2>

// 然后也有多行的如@eq3，标签名字可以自定义

// #equation(
//   $ sum_(k=0)^n k
//     &< 1 + ... + n \
//     &= (n(n+1)) / 2 $,
// ) <eq3>


// 如果不想编号就直接用\$即可


// $ x < y => x gt.eq.not y $

// == 列表

// - 无序列表1: 1

// - 无序列表2: 2

// #indent()列表后的正文，应当有缩进。这里加入一个 \#indent() 函数来手动生成段落缩进，是因为在目前的 typst 设计里，按英文排版的习惯，连续段落里的第一段不会缩进，也包括各种列表。

// 1. 有序列表1
// 2. 有序列表2

// 列表后的正文，应当有缩进，但是这里没有，请自己在段首加上\#indent()

// 想自己定义可以自己set numbering，建议用 \#[] 包起来保证只在该作用域内生效：

// #[
// #set enum(numbering: "1.a)")
// + 自定义列表1
//   + 自定义列表1.1
// + 自定义列表2
//   + 自定义列表2.1
// ]

// == 代码块

// //代码块使用的是库codelst，语法和markdown类似
// #sourcecode[```typ
// #show "ArtosFlow": name => box[
//   #box(image(
//     "logo.svg",
//     height: 0.7em,
//   ))
//   #name
// ]

// This report is embedded in the
// ArtosFlow project. ArtosFlow is a
// project of the Artos Institute.
// ```]

// #pagebreak()
// = 其他说明

// == 文献引用

// 引用支持 LaTeX Bib 的格式，也支持更简单好看的 yml 来配置，在引用时使用#bib_cite(<harry>)#bib_cite(<某本参考书>)以获得右上的引用标注。


// 记得在最后加入\#references("xxxref.yml")函数的调用来生成参考文献。

// *尚不支持国标，自定义参考文献功能官方正在开发中*

// == 致谢部分

// 致谢部分在最后加入\#acknowledgement()函数的调用来生成。


// == 模板相关

// 这个模板应该还不是完全版，可能不能覆盖到华科论文的所有case要求，如果遇到特殊 case 请提交 issue 说明，或者也可以直接提 pull request

// 同时，由于 typst 太新了，2023年4月初刚发布0.1.0版本，可能会有大的break change发生，模板会做相应修改。

// 主要排版数据参考来自 https://github.com/zfengg/HUSTtex 同时有一定肉眼排版成分，所以有可能不完全符合华科排版要求，如果遇到不对的间距、字体等请提交 issue 说明。

// === 数据相关

// 所有拉丁字母均为 Times New Roman，大小与汉字相同

// 正文为宋体12pt，即小四

// 图表标题为黑体12pt

// 表格单元格内容宋体10.5pt，即五号

// 一级标题黑体18pt加粗，即小二

// 二级标题14pt加粗，即四号

// 正文行间距1.24em（肉眼测量，1.5em与与word的1.5倍行距并不一样）

// a4纸，上下空2.5cm，左右空3cm

// #pagebreak()
// = 这是一章占位的

// == 占位的二级标题 1

// == 占位的二级标题 2

// == 占位的二级标题 3

// == 占位的二级标题 4

// === 占位的三级标题 1

// === 占位的三级标题 2

// ==== 占位的四级标题 1

// ==== 占位的四级标题 2

// == 占位的二级标题 5

// == 占位的二级标题 6



// #pagebreak()
// #acknowledgement()[
  
// 完成本篇论文之际，我要向许多人表达我的感激之情。

// 首先，我要感谢我的指导教师，他/她对本文提供的宝贵建议和指导。所有这些支持和指导都是无私的，而且让我受益匪浅。

// 其次，我还要感谢我的家人和朋友们，他们一直以来都是我的支持和鼓励者。他们从未停止鼓舞我，勉励我继续前行，感谢你们一直在我身边，给我幸福和力量。

// 此外，我还要感谢我的同学们，大家一起度过了很长时间的学习时光，互相支持和鼓励，共同进步。因为有你们的支持，我才能不断地成长、进步。

// 最后，我想感谢笔者各位，你们的阅读和评价对我非常重要，这也让我意识到了自己写作方面的不足，同时更加明白了自己的研究方向。谢谢大家！

// 再次向所有支持和鼓励我的人表达我的谢意和感激之情。

// 本致谢生成自 ChatGPT。
// ]

// #pagebreak()

// // #let references(path) = {
// //   // 这个取消目录里的 numbering
// //   set heading(level: 1, numbering: none)

// //   set par(justify: false, leading: 1.24em, first-line-indent: 2em)
  
// //   show bibliography: it => {
// //     [= 参考文献]
// //     let bib = yaml("./bibitems.yaml")
// //     // let bib = yaml("arr.yaml")
// //     let idx = 0
// //     set par(leading: 1.24em)
// //     grid(
// //       columns: (1fr, 15fr),
// //       row-gutter: 1.24em,
// //       ..bib.enumerate().map(((idx, title)) => {
// //         ([[#{idx+1}]], title)
// //       }).flatten()
// //     )
// //   }
// //   bibliography(path, title:"参考文献")
// // }

// #references("./ref.yml")

// #pagebreak()
// #indent() 由于华科使用自创引用格式，基本上为 GB/T 7714 去掉[J]、[C]、[M] 等。所以需要用 show rule 来自定义格式，原理为读取自定义的 bibitems.yaml 文件再一项项渲染出来，因此要求自己维护顺序，使用时请取消 \#references() 前的注释。
