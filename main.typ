#import "template.typ": *
#import "@preview/codelst:2.0.0": sourcecode

#show: project.with(
  anony: false,
  title: " ",
  author: "张钧玮          马耀辉         夏彦文",
  school: "计算机学院",
  group:"OmegaXYZ",
  id: "U202115520   U202115638   U202115317",
  mentor: "潘鹏",
  class: "大数据 2101 班    大数据2102班",
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

= 任务书
=== 总体要求
1. 综合运用软件工程的思想，协同完成一个软件项目的开发，掌软件工程相关的技术和方法；
2. 组成小组进行选题，通过调研完成项目的需求分析，并详细说明小组成员的分工、项目的时间管理等方面。
3. 根据需求分析进行总体设计、详细设计、编码与测试等。
=== 基本内容
1. 综合运用软件工程的思想，协同完成一个软件项目的开发，掌软件工程相关的技术和方法；
2. 组成小组进行选题，通过调研完成项目的需求分析，并详细说明小组成员的分工、项目的时间管理等方面。
3. 根据需求分析进行总体设计、详细设计、编码与测试等。





#pagebreak()

= 问题定义
== 项目背景与意义


== 项目基本目标

== 可行性分析




== 人员管理和项目进度管理

#pagebreak()





#pagebreak()
= 需求分析
== 后端
===  需求分析概述
=== UML相关需求分析图
=== 原型系统设计
#pagebreak()
= 概要设计和详细设计
== 后端
=== 系统结构
=== 类图等
=== 关键数据结构定义
#sourcecode[```typ
#show "ArtosFlow": name => box[
  #box(image(
    "logo.svg",
    height: 0.7em,
  ))
  #name
]

This report is embedded in the
ArtosFlow project. ArtosFlow is a
project of the Artos Institute.
```]

== 数据管理说明
#pagebreak()
= 实现与测试
== 关键函数说明
== 测试计划和测试用例
== 结果分析
#pagebreak()

= 总结
== 用户反馈
== 全文总结

#pagebreak()

= 体会
// #indent() //由于华科使用自创引用格式，基本上为 GB/T 7714 去掉[J]、[C]、[M] 等。所以需要用 show rule 来自定义格式，原理为读取自定义的 bibitems.
// //yaml 文件再一项项渲染出来，因此要求自己维护顺序，使用时请取消 \#references() 前的注释。
#pagebreak()

= 附录