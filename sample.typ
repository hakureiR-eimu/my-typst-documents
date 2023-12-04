#import "template.typ": *

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
#indent() 