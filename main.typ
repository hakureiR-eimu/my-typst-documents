#import "template.typ": *

#show: project.with(
  anony: false,
  title: " ",
  author: "张钧玮          马耀辉         夏彦文",
  school: "计算机学院",
  group:"OmegaXYZ",
  id: "U202115520   U2021114514   U202115317",
  mentor: "潘鹏",
  class: "大数据 2102 班",
  date: (2023, 11, 30)
)

//
//#img(
//  image("assets/avatar.jpeg", height: 20%),
//  caption: "我的 image 实例 0",
//)

//== 函数式语言家族成员调研
//
//=== 代码执行
//
//正文可以像前面那样直接写出来，隔行相当于分段。
//
//个人理解：typst 有两种环境，代码和内容，在代码的环境中会按代码去执行，在内容环境中会解析成普通的文本，代码环境用{}表示，内容环境用[]表示，在 content 中以 \# 开头来接上一段代码，比如\#set rule，而在花括号包裹的块中调用代码就不需要 \#。
//
//
//=== 标题
//
//类似 Markdown 里用 \# 表示标题，typst 里用 = 表示标题，一级标题用一个 =，二级标题用两个 =，以此类推。
//
//
//间距、字体等会自动排版。
//
//\#pagebreak() 函数相当于分页符，在华科的要求里，第一级标题应当分页，请手动分页。
//
//#pagebreak()

= 课程任务概述

在云平台部署图数据库 Neo4j ，关系数据库 MySQL ，文档数据库 MongoDB ，完成对应数据集的导入和初始化，然后根据课程任务编写一系列增删改查的任务，关注不同数据库的使用体验和性能差异以及在不同场景下的适用性。

#pagebreak()

= 实验任务一 （Mysql for Json实验）
== 任务要求

在华为云服务器上安装 MySQL 并且导入 test 数据库
== 完成过程

在华为云服务器上安装 MySQL 并且导入 test 数据库。
== 任务小结

`
编写函数treecompare, SwapDown 和heapify：
`

`
treecompare: tree * tree -> order
(* when given two trees, returns a value of type order, based on which tree has a larger value at the root node *)

`

`
SwapDown: tree -> tree
(* REQUIRES the subtrees of t are both minheaps )
( ENSURES swapDown(t) = if t is Empty or all of t’s immediate children are empty then * just return t, otherwise returns a minheap which contains exactly the elements in t. *)

`




#pagebreak()





#pagebreak()
= 实验任务二  ( MongoDB 实验)
== 任务要求
== 完成过程
== 任务小结
#pagebreak()
= 实验任务三  ( Neo4j 实验)
== 任务要求
== 完成过程
== 任务小结
#pagebreak()
= 实验任务四 (多数据库交互应用实验)
== 任务要求
== 完成过程
== 任务小结
#pagebreak()

= 实验任务五(不同类型数据库 MVCC 多版本并发控制对比实验)
== 任务要求
== 完成过程
== 任务小结
#pagebreak()

= 课程总结
#indent() //由于华科使用自创引用格式，基本上为 GB/T 7714 去掉[J]、[C]、[M] 等。所以需要用 show rule 来自定义格式，原理为读取自定义的 bibitems.
//yaml 文件再一项项渲染出来，因此要求自己维护顺序，使用时请取消 \#references() 前的注释。
