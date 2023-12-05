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
== 任务要求一

在华为云服务器上安装 MySQL 并且导入 test 数据库，然后完成诸个实验任务。由于页数要求，挑选以下典型题目进行叙述：

①JSON聚合与索引的题目12

②JSON聚合与索引的题目13。

12题实验要求如下：在 tip 表中找到被提建议最多的商户和提出建议最多的用户,合并二者的 info列的 JSON 文档为一个文档显示,对于 JSON 文档中相同的 key 值,应该保留二者的 value 值.

13题要求如下：查询被评论数前三的商户,使用 JSON_TABLE()导出他们的名字,被评论数,是否在星期二营业(即"hours"中有"Tuesday"的键值对,是返回 1,不是返回 0),和一周所有的营业时段(不考虑顺序,一个时段就对应一行,对每个商户,从 1 开始对这些时段递增编号), 最后按商户名字升序排序
== 完成过程
配置mysql环境以及导入数据库的过程不再赘述。以下是代码以及思路：
=== 题目12


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

=== 题目13
#sourcecode[```sql
JSON_UNQUOTE(JSON_EXTRACT(business_info, '$.name')) AS name,
JSON_UNQUOTE(JSON_EXTRACT(business_info, '$.review_count')) AS review_count,
IF(tuesday IS NULL, 0, 1) AS is_open_on_tuesday,
ROW_NUMBER() OVER () AS num,
monday, tuesday, wednesday, thursday, friday, saturday, sunday
FROM
(
    SELECT
        business_id,
        business_info
    FROM
        business
    ORDER BY
        JSON_EXTRACT(business_info, '$.review_count') DESC
    LIMIT 3
) AS top_3_businesses,
JSON_TABLE(
    business_info, '$.hours' COLUMNS (
        monday VARCHAR(20) PATH '$.Monday',
        tuesday VARCHAR(20) PATH '$.Tuesday',
        wednesday VARCHAR(20) PATH '$.Wednesday',
        thursday VARCHAR(20) PATH '$.Thursday',
        friday VARCHAR(20) PATH '$.Friday',
        saturday VARCHAR(20) PATH '$.Saturday',
        sunday VARCHAR(20) PATH '$.Sunday'
    )
) AS operating_hours
ORDER BY
    name ASC;

```]
13题难度较高，查询较为复杂。首先需要定位所需资源的位置。

mysql的business表有两个个属性分别是business_id，business_info。后者是一个json对象。

详细解析business_info,'\$.name'字段是商家的名字，'\$.review_count'是评论数，'\$.hours.Tuesday'是星期二的营业时间，其他运营时间以此类推,这里通过简单的条件判断把是否在周二营业可以转换成0和1的形势。

接下来简单查询获取被评论数前三的商户，使用JSON_EXTRACT降序提取出被评论数最多的商家然后取前三即可。

然后需要把营业时间的信息提取出来，这里使用了JSON_TABLE函数，它可以把json对象转换成表的形式，我用它把周一到周日的营业时间转换成了表。JSON_TABLE函数的第一个参数是json对象，第二个参数是json对象的路径，第三个参数是列名和路径的对应关系。这里需要注意的是，json对象的路径是从根节点开始的，而不是从当前节点开始的。因此这里的路径是\$.hours。这样就把营业时间段提取出来了。

最后使用了union函数把每个商家的营业时间按照顺序编号，完成查询。

== 任务小结

=== 题目12
#img(
    image("assets\image-20231019201914323.png"),
    caption: "JSON_MERGE_PATCH 函数的使用"
)<img1>

经过结果参考表可知，结果正确。

=== 题目13

经过结果参考表可知，结果正确。但是我发现保存下来的是错误的图片，服务器又钱花完已经释放掉了，图片仅供参考。
#img(
    image("assets\image-20231019201931204.png"),
    caption: "JSON_MERGE_PATCH 函数的使用"
)<img1>
#pagebreak()
= 实验任务二  ( MongoDB 实验)
== 任务要求

在华为云远程服务器上配置MongoDB环境，导入数据集，完成诸个实验任务。由于页数要求，挑选典型题目：题目 12 作为叙述对象。题目详细要求如下：

在 Subreview 集合中统计评价中 useful、funny 和 cool 都大于 6 的商家返回商家 id 及平均打星，并按商家 id 降序排列。
== 完成过程

详细代码如下：
#sourcecode(```MongoDB
const database = 'yelp';
const collection = 'NEW_COLLECTION_NAME';

// The current database to use.
use(database);

// Create a new collection.
// 题目要求
// 题目要求
db.Subreview.aggregate([
    {$match: {useful: {$gt: 6}, funny: {$gt: 6}, cool: {$gt: 6}}},
    {$group: {_id: "$business_id", average_stars: {$avg: "$stars"}}},
    {$sort: {_id: -1}}
  ])
```)

== 思路简述和感想


mongoDB是快速上手的文档数据库，操作和web的开发语言javascript十分相似，上手难度不大。mongo的数据层级是database-collection，基本查询操作就是选择数据库然后对db对象的对应集合进行操作。

在这道题中，首先需要我了解并且使用aggregate。aggregate 是 MongoDB 中用于数据聚合的强大工具。aggregate 操作可用于对文档进行多个阶段的处理，每个阶段的输出是下一个阶段的输入。

因此按照题意，我在aggregate里首先使用match筛选出符合要求大于6的数据，然后使用group按照商家id进行分组，并且把商家的平均打分作为聚合值返回，最后对商家id进行降序排列。
== 任务小结
#img(
    image("assets\image-20231019102634646.png"),
    caption: "aggregate的使用"
)<img1>

经过结果参考表可知，结果正确。
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