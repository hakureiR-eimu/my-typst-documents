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


= 教师评分页
#align(center)[
  #table(
    columns:(auto,auto),
    inset:20pt,
    align: horizon,
    [子目标],[子目标评分],
    [1]," ",
    [2]," ",
    [3]," ",
    [4]," ",
    [5]," ",
    [6]," ",
    [7]," ",
    [总分]," "
  )
]
#pagebreak()
= 课程任务概述

在云平台部署图数据库 Neo4j ，关系数据库 MySQL ，文档数据库 MongoDB ，完成对应数据集的导入和初始化，然后根据课程任务编写一系列增删改查的任务，按照课程要求同时关注不同数据库的使用体验和性能差异以及在不同场景下的适用性。体会不同数据库的特点，优势和适用范围。

该实验报告使用typst编辑完成。Typst是一个排版文档的标记语言。它被设计为易于学习， 速度快，用途广泛。Typst获取带有标记的文本文件并输出为PDF文件。Typst适合撰写长篇文本（如论文、文章、科学论文、书籍、报告和家庭作业）。此外，Typst非常适合于编写任何包含数学符号的文档，例如在数学、物理和工程领域的论文。最后，由于其强大的风格化和自动化功能，它是任何一组具有共同风格的文件的绝佳选择，例如丛书。

#pagebreak()

= 实验任务一 （Mysql for Json实验）
== 任务要求

在华为云服务器上安装 MySQL 并且导入 test 数据库，然后完成诸个实验任务。由于页数要求，挑选典型题目：JSON聚合与索引的题目12作为叙述对象。

实验要求如下：在 tip 表中找到被提建议最多的商户和提出建议最多的用户,合并二者的 info列的 JSON 文档为一个文档显示,对于 JSON 文档中相同的 key 值,应该保留二
者的 value 值.
== 完成过程

配置mysql环境以及导入数据库的过程不再赘述。以下是代码以及思路：

#sourcecode[```sql
SELECT  u.user_id,
        b.business_id,
        JSON_MERGE_PATCH(b.business_info, u.user_info) 
        AS merged_info
FROM (
    SELECT t.business_id
    FROM (
        SELECT business_id, COUNT(*) AS tip_count
        FROM tip
        GROUP BY business_id
        ORDER BY tip_count DESC
        LIMIT 1
    ) AS t
) AS bt
JOIN business b ON bt.business_id = b.business_id
JOIN (
    SELECT t.user_id
    FROM (
        SELECT user_id, COUNT(*) AS tip_count
        FROM tip
        GROUP BY user_id
        ORDER BY tip_count DESC
        LIMIT 1
    ) AS t
) AS ut
JOIN user u ON ut.user_id = u.user_id;
```]


使用聚合查找首先找到tip表中被提建议最多的商家ID，
然后找出提出建议最多的用户ID，
将这两个表连接以后使用JSON_MERGE_PATCH 函数将商户信息和用户信息合并为一个 JSON 文档。

这里使用的JSON_MERGE_PATCH 使用函数是用于合并两个 JSON 对象的 MySQL 函数。它接受两个 JSON 参数，并返回一个新的 JSON 对象，其中包含了两个输入对象的合并结果。完美符合了题目的需求

== 任务小结

#img(
    image("assets\image-20231019201914323.png"),
    caption: "JSON_MERGE_PATCH 函数的使用"
)<img1>

经过结果参考表可知，结果正确。

#pagebreak()
= 实验任务二  ( MongoDB 实验)
== 任务要求

在华为云远程服务器上配置MongoDB环境，导入数据集，完成诸个实验任务。由于页数要求，挑选典型题目：题目 12 作为叙述对象。题目详细要求如下：

在 Subreview 集合中统计评价中 useful、funny 和 cool 都大于 6 的商家返回商家 id 及平均打星，并按商家 id 降序排列。
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