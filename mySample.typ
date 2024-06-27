#import "myTemplate.typ": *
#import "@preview/codelst:2.0.0": sourcecode


#show: project.with(
  anonymous: false,
  title: "大数据算法实践",
  author: "张钧玮",
  school: "计算机学院",
  id: "U202115520",
  mentor: "刘海坤",
  class: "大数据 专业 2102 班",
  date: (2024, 6, 25)
)


= 实验

大规模图数据中三角形计数算法的设计与性能优化

== 实验目的

本实验旨在通过⼤规模图数据中三⻆形计数算法的设计与性能优化，帮助深⼊理解图计算系统的⼯作原理和性能优化机制，并学会使⽤图计算框架进⾏⼤规模图数据分析和处理。通过此实验，学⽣将能够掌握图计算的基本概念、编写⽐较复杂的图算法程序并进⾏性能调优。
== 实验内容

本实验要求在给定服务器平台，以及数据集上实现三⻆形计数（Triangle Counting，TC）算法，调试并获得最⾼的性能。

== 程序设计

使用Spark GraphX框架实现三⻆形计数算法。在大图上，因为数据集较大会产生内存溢出，gc调度密集，进程被杀死等问题，因此对于大图，使用以下优化技术：
1. 顶点划分：将图划分为多个⼦图，每个⼦图包含⼀部分顶点和相应的边。每个⼦图在⼀个独⽴的进程中运⾏，并且⼦图之间的通信通过消息传递进⾏。
2. 持久化：将图数据持久化到磁盘，以减少内存占⽤。
3. 增加spark.executor.memory和spark.driver.memory参数，以增加内存使⽤。
4. 增加并行度：增加spark.default.parallelism参数，以增加并⾏度。
5. 优化gc策略：使用G1GC垃圾回收器，以减少gc时间。

== 实验过程

1. #emph([/usr/local/hadoop/sbin/start-dfs.sh ])  开启hadoop集群
2. #emph([/usr/local/sbt/sbt package])    编译打包项目
3. #emph([hdfs dfs -put ./input/\* input/TriangleCounting/  ])    上传数据集
4. #emph([/usr/local/spark/bin/spark-submit \
    --conf spark.executor.extraJavaOptions=-XX:+UseG1GC --conf spark.driver.extraJavaOptions=-XX:+UseG1GC \
    --conf spark.default.parallelism=200 \
    --executor-memory 50G \
    --driver-memory 50G \
    --class "TriangleCounting" \
    /home/usami/workU/BigDataSystem/SparkTasks/TriangleCounting/target/scala-2.12/trianglecounting_2.12-1.0.jar \
    2>&1
 ])     运行程序

=== 问题出现

默认参数下运行有以下问题：
1. 运行速度慢
2. 内存溢出
3. gc调度密集
报错如下图：
#img(
  image("assets/Snipaste_2024-06-27_11-09-45.png", height: 20%),
  caption: "运行报错"
)

=== 问题分析

使用以下办法依次解决问题：
1. 开启多线程核心吃满
2. 增加spark.executor.memory和spark.driver.memory参数，以增加内存使⽤
3. 增加并行度：增加spark.default.parallelism参数，以增加并⾏度
4. 优化gc策略：使用G1GC垃圾回收器，以减少gc时间

== 实验结果与分析

#sourcecode[```bash
[data] Total triangles count: 3830604
[data] Time taken: 4304 ms
```]使用多线程结果
#img(
  image("assets/Snipaste_2024-06-27_11-13-29.png", height: 20%),
  caption: "cpu调度图"
)
可以看到cpu核心被充分利用，运行速度明显提升，内存溢出问题得到解决，gc调度密集问题也得到解决。

== 心得体会

这个课不错，可惜实习缘故没有时间好好写。没有好好用上以下的并行编程知识。
大学的并行编程我主要学了以下的内容：
1. omp的循环展开，这个真的很方便，如果是互不干扰的循环进程比如矩阵乘法用omp库可以自动把核心吃满
2. 异步编程，c\#,js，c++都有的异步组件。async/await，解决了进程阻塞的问题，避免了轮询造成的cpu浪费，把一个异步问题转换成状态迁移，是常用的编程模型，降低心智负担，👍
3. 多线程编程，c++的std::thread。因为如果没有并发冲突与omp无异，而假如有并发冲突，可以使用std::mutex来实现进程同步

= 附录：实验目录结构

#sourcecode[```bash
# usami @ CodeOfUsami in ~/workU/BigDataSystem/SparkTasks/TriangleCounting on git:main o [11:15:43] 
$ git ls-files
.gitignore
README.md
build.sbt
run.sh
src/main/scala/TriangleCounting.scala
```]
// == typst 介绍


// #img(
//   image("assets/avatar.jpeg", height: 20%),
//   caption: "我的 image 实例 0",
// )

// == 基本语法

// === 代码执行

// 正文可以像前面那样直接写出来，隔行相当于分段。

// 个人理解：typst 有两种环境，代码和内容，在代码的环境中会按代码去执行，在内容环境中会解析成普通的文本，代码环境用{}表示，内容环境用[]表示，在 content 中以 \# 开头来接上一段代码，比如\#set rule，而在花括号包裹的块中调用代码就不需要 \#。


// === 标题

// 类似 Markdown 里用 \# 表示标题，typst 里用 = 表示标题，一级标题用一个 =，二级标题用两个 =，以此类推。


// 间距、字体等会自动排版。

// \#pagebreak() 函数相当于分页符，在华科的要求里，第一级标题应当分页，请手动分页。


// = 本模板相关封装



// 图用下面的方式来引用，img 是对 image 的包装，caption 是图片的标题。

// #img(
//   image("assets/avatar.jpeg", height: 20%),
//   caption: "我的 image 实例 1",
// ) <img1>

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

// 引用支持 LaTeX Bib 的格式，也支持更简单好看的 yml 来配置（尚未流行，推荐优先使用`.bib`）在引用时使用`#bib_cite(<tag>)`，像这样#bib_cite(<impagliazzo2001problems>,<Burckhardt:2013>)以获得右上的引用标注#bib_cite(<刘星2014恶意代码的函数调用图相似性分析>)#bib_cite(<papadimitriou1998combinatorial>)。

// 记得在最后加入\#references("path/to/ref.bib")函数的调用来生成参考文献。

// 由于华科使用自创引用格式，基本上为 GB/T 7714 去掉[J]、[C]、[M] 刊物类型。Typst 已支持 `csl` 自定义参考文献列表，基于#link("https://github.com/redleafnew/Chinese-STD-GB-T-7714-related-csl/blob/main/462huazhong-university-of-science-and-technology-school-of-cyber-science-and-engineering.csl")[#underline()[这个]]修改，如果想再自定义新的格式，请修改 `template.typ` 中 `bibliography` 函数中 style 参数。


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

// #references("./ref.bib")
