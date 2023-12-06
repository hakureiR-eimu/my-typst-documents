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

这里使用的JSON_MERGE_PATCH 使用函数是用于合并两个 JSON 对象的 MySQL 函数。它接受两个 JSON 参数，并返回一个新的 JSON 对象，其中包含了两个输入对象的合并结果。这道题目需要的正是返回JSON格式文档，这个函数完美符合了题目的需求。

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
    caption: "JSON_MERGE_PATCH 函数的使用的返回结果"
)<img1>
#img(
    image("assets\Snipaste_2023-12-06_11-43-39.png"),
    caption: "实验结果参考"
)<img1>

经过结果参考表可知，结果正确。

=== 题目13

经过结果参考表可知，结果正确。但是我发现保存下来的是错误的图片，服务器又因为钱花完已经释放掉了，图片仅供参考。
#img(
    image("assets\image-20231019201931204.png"),
    caption: "Mysql-Json复杂查询的返回结果"
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
    caption: "aggregate的使用的返回结果"
)<img1>
#img(
    image("assets\Snipaste_2023-12-06_11-50-11.png"),
    caption: "实验结果参考"
)<img1>
经过结果参考表可知，结果正确。
#pagebreak()
= 实验任务三  ( Neo4j 实验)
== 任务要求

在华为云远程服务器上安装并且配置Neo4j环境并且完成一系列图查询实验。

neo4j是一个流行的图数据库，它的数据结构是图，图是由节点和关系组成的。neo4j的查询语言是cypher，它的语法和sql有很大的不同，但是也有很多相似的地方。cypher的查询语句是由match，where，return组成的。match用于匹配节点和关系，where用于筛选，return用于返回结果。以上就是neo4j的简要介绍

Neo4j实验挑选题目10作为典型题目。下面给出详细题目和解题过程：

10.查询 Allison 的朋友（直接相邻）分别有多少位朋友。(考察：使用 with 传递查询结果到后续的处理)

== 完成过程

首先给出实验代码：
#sourcecode(```cypher
MATCH(:UserNode{name:'Allison'})-[:HasFriend]->(friend)
WITH friend.name as friendsList, 
size((friend)-[:HasFriend]-()) as number0fFoFs
RETURN friendsList,number0fFoFs
```) 
图查询的重点就是提取题目的所需节点和节点与节点之间的关系。

对于这道题，首先Allison的属性是UserNode，想要查询他的朋友们就需要通过朋友这个关系来获取，因此是MATCH(:UserNode{name:'Allison'})-[:HasFriend]->(friend)。

再然后，题目已经提醒我们通过with来传递查询结果到后续的处理。因此对于每个朋友，都应该使用和上一步类似的方法查询与他们存在朋友关系的节点，使用size（）聚合函数以单个Allison的朋友作为对象返回这些朋友节点的数量，加上朋友的名字，就是这道题目的答案了。

== 任务小结

返回结果与参考答案一致，因此结果正确。
#img(
    image("assets\image-20231030203541194.png"),
    caption: "neo4j查询"
)<img1>
#img(
    image("assets\Snipaste_2023-12-06_11-59-42.png"),
    caption: "实验结果参考"
)<img1>
#pagebreak()
= 实验任务四 (多数据库交互应用实验)
== 任务要求

多数据库交互应用实验具体就是使用neo4j，mongoDB执行依次的任务，前者的输入是后者的输出，通过这个实验可以体会到不同数据库的优势和适用范围。题目2的输入是题目1的输出，因此下面将是题目1和题目2两个实验共同完成。以下是具体的题目要求：

题目1：使用 Neo4j 查找：找出评论过超过 5 家不同商户的用户，并在 Neo4j 以表格形式输出满足以上条件的每个用户的信息：name, funny, fans。
题目2：将 1 得到的结果导入 MongoDB，并使用该表格数据，统计其中所有出现的
用户名及该用户名对应的出现次数，并按照出现次数降序排序,使用 aggregate
实现
== 完成过程

首先依次给出题目1和题目2的代码：
#sourcecode(```cypher
MATCH (user:UserNode)-[:Review]->(review:ReviewNode)-[:Reviewed]->(business:BusinessNode)
WITH user,count(distinct(business)) AS reviewCount
WHERE reviewCount > 5
RETURN user.name,user.funny,user.fans
```)题目1
#sourcecode(```MongoDB
 mongoimport --db Mydb --collection collection41 --file ~/resulttask4/records2.json --jsonArray
```)命令行代码，以上为一行命令
#sourcecode(```MongoDB

use('Mydb');

db.collection43.aggregate([
    { $group: { _id: '$name', count: { $sum: 1 } } },
    { $sort: { count: -1 } }
  ]);
  db.collection43.mapReduce(
    function() {
      emit(this.name, 1);
    },
    function(key, values) {
      return Array.sum(values);
    },
    {
      out: { inline: 1 },
      finalize: function(key, reducedValue) {
        return { count: reducedValue };
      }
    }
  )
```)
题目2

题目1思路：

1、找到评论用户： 使用 Cypher 查询语句，匹配评论节点到用户节点的关系，统计每个用户评论过的不同商户数量。用 MATCH 和 COUNT 来实现。

2、过滤用户： 在查询中添加条件，仅选择评论过不同商户数量大于 5 的用户。用 WHERE 子句进行过滤。

3、获取用户信息： 使用之前筛选出的用户节点，进一步查询用户的信息，如用户名（name）、有趣指数（funny）、粉丝数量（fans）等。

4、以表格形式输出： 最终结果通过 RETURN 子句指定要输出的用户信息，并在 Neo4j 中以表格形式显示然后下载导出结果为JSON格式数据。

题目2思路：

1、首先使用上方给出的命令行代码把数据导入到MongoDB中。
2、使用aggregate函数依次执行group和sort操作，group操作是按照name分组，然后使用count函数统计每个name出现的次数，sort操作是按照count降序排列。

== 任务小结
#img(
    image("assets\image-20231031144633002.png"),
    caption: "题目4-1结果"
)<img1>
#img(
    image("assets\image-20231031183544451.png"),
    caption: "题目4-2结果"
)<img1>
#img(
    image("assets\Snipaste_2023-12-06_17-03-00.png"),
    caption: "题目4-1参考结果"
)<img1>
#img(
    image("assets\Snipaste_2023-12-06_17-03-11.png"),
    caption: "题目4-2参考结果"
)<img1>
经过结果参考表可知，结果正确。
#pagebreak()

= 实验任务五(不同类型数据库 MVCC 多版本并发控制对比实验)
== 任务要求

自行构造多用户同时对同一数据库对象的增删改查案例，
实验对比 MySQL 和 MongoDB 数据库对 MVCC 多版本并发控制的支持。
1. 体验 MySQL 在 InnoDB 存储引擎下的 MVCC 多版本并发控制，实现的事务
ACID 特性。请注意 Mysql 需要选用什么事务隔离级来支持 MVCC？请构造
多用户多写多读案例来展现 MVCC 并发控制特性，解释各种结果产生的原
因。
2. 体验 MongoDB 的 MVCC，数据集可自建或选用 yelp 数据集中的 test 集合中
进行测试，测试方法同 MySQL。请对测试结果进行说明，并与 MySQL 的
MVCC 实验结果进行对比分析。建议创建 MongoDB 副本或分片集群，体验
MVCC 的不同效果（可选做其一）

这里选择题目1作为典型案例，示范数据库如何实现MVCC的多版本并发支持控制。
== 完成过程

首先给出一个没有设置事务隔离级别的导致不可重复读的例子：
#img(
    image("assets\Snipaste_2023-12-06_17-28-16.png"),
    caption: "事务2"
)<img1>
首先执行事务2，可见mrfz的值为4
#img(
    image("assets\Snipaste_2023-12-06_17-30-02.png"),
    caption: "事务1"
)<img1>
然后执行事务1，更新mrfz的值为5
#img(
    image("assets\Snipaste_2023-12-06_17-31-01.png"),
    caption: "事务2"
)<img1>
再次执行事务二，发现mrfz的值已经变成5了。

事务2两次执行没有改变mrfz的值但是读出来的值不同，这在生产环境中会导致错误和bug的产生，因此需要使用命令行把事务隔离级别设置为可重复读（REPEATABLE READ）。

以下是切换了事务隔离等级以后的情况。首先执行事务2：
#img(
    image("assets\Snipaste_2023-12-06_17-38-49.png"),
    caption: "事务2"
)<img1>
然后执行事务1发现mrfz的值为6，然后修改mrfz的值为6.
#img(
    image("assets\Snipaste_2023-12-06_17-39-04.png"),
    caption: "事务1"
)<img1>
最后使用事务2读取，发现mrfz的值仍然是5：
#img(
    image("assets\Snipaste_2023-12-06_17-40-49.png"),
    caption: "事务2"
)<img1>
由此可见设置可重复读的事务隔离级别以后，事务2读取的值不会随着事务1的修改而改变，这就是MVCC的多版本并发控制。可以解决不可重复读问题。

同理，写写问题就是事务2改变了某个值，而事务1又改变了这个值，因此覆盖了事务2的修改，这里可以通过对数据加锁来完成。
== 任务小结

原理：在"可重复读"事务隔离级别下，MySQL使用MVCC来处理并发事务。MVCC通过创建数据的快照视图（snapshot view）来实现事务的隔离性。每个事务在开始时会创建一个一致性的快照视图，该视图会记录事务开始时数据库中的数据状态。事务执行期间，其他事务对数据的修改不会对当前事务的查询结果产生影响。
"可重复读"事务隔离级别确保了每个事务在整个过程中看到的数据是一致的，即使其他事务对数据进行了修改。这种隔离级别适用于多用户并发访问数据库的场景，并保证了事务的ACID特性。
通过选择"可重复读"事务隔离级别，MySQL能够支持MVCC并发控制，保证了事务的一致性和隔离性。

#pagebreak()

= 课程总结

本次实验通过数十个不同的题目，配置并且使用了不同种类的数据库，例如文档数据库，图数据库，关系型数据库等。

通过这些题目，我对不同种类的数据库有了更深入的了解，也对数据库的使用有了更多的经验。更加了解不同数据库的适应范围和优势领域，以及为什么我们需要不同的数据库：因为大数据时代的到来，数据量越来越大，数据的类型也越来越多，适用范围单一的关系型数据库以及越来越不能满足性能和更多需求的要求了。

通过大数据管理实验这门课，我对数据库领域的知识和能力都获得了提高和加强，很满意。
#indent() 