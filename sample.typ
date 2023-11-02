#import "template.typ": *

#show: project.with(
  anony: false,
  title: " ",
  author: "张钧玮",
  school: "计算机学院",
  id: "U202115520",
  mentor: "顾琳",
  class: "大数据 2102 班",
  date: (2023, 10, 22)
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

= 函数式语言家族成员调研

== 函数式语言简介


函数式语言是一种非冯诺依曼式的计算机编程语言，它将计算过程视为数学函数的求值，避免了状态和可变数据。函数编程语言具有没有变量和副作用,函数为一等公民,适合于并发程序等特点。

== 函数式语言家族成员


1.Haskell


Haskell 语言是很多北美名校计算机的入门编程语言,这是一门富有数学魅力的编程语言。


2.Meta Language


本次课程学习使用的编程语言，这门语言是为了帮助在 LCF 定理证明机中寻找证明策略而构想出来的。ML 是兼具一些指令式特征的函数式编程语言。ML 的特征包括：传值调用的求值策略，头等函数，带有垃圾收集的自动内存管理，参数多态，静态类型，类型推论，代数数据类型，模式匹配和异常处理。


3.Lisp


Lisp 是一种基于符号的编程语言，它是第一种被广泛使用的高级语言，也是第一种被广泛使用的函数式编程语言。Lisp 是一种多范式的编程语言，它支持过程式编程，函数式编程，面向对象编程和元编程。Lisp 的语法是由 S 表达式表示的，它使用前缀表示法，它的函数调用和语法规则都是一样的。


4.Java


Java8 通过 lambda 表达式、Stream API引入了函数式编程。事实上很多高级语言例如 C++ 或者 Python 近10年都增加了函数式编程的支持。


#pagebreak()


= 上机实验心得体会

== 实验 3.4 heapify

== heapify 的定义

heapify ( 最小堆 )是一个函数，它将一个无序的数组转换成一个堆。一棵 minheap 树定义为：

t is Empty;

t is a Node(L, x, R), where R, L are minheaps and values(L), value(R) >= x (value(T)函数用于获取树T的根节点的值）;

=== 实验要求

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

`
heapify : tree -> tree
(* given an arbitrary tree t, evaluates to a minheap with exactly the elements of t.  *)

`

=== 实验思路

函数 treecompare 是易于实现的。只需要比较二叉树节点的两个子节点。首先考虑两个节点中存在空节点的情况，如果有一个子节点为空，那么它自然小于另外一个非空子节点，函数值为 LESS 或者 GREATER 。倘若两个子节点都为空，那么函数值应当为 EQUAL 。若两个子节点均为非空，则通过构造函数 br 比较两个子节点的值，返回 LESS 或者 GREATER 。实验代码如下：
`
fun treecompare (Empty, Empty) = EQUAL
  | treecompare (Empty, _) = LESS
  | treecompare (_, Empty) = GREATER
  | treecompare (Br(_, a1, _), Br(_, a2, _)) =
    case Int.compare(a1, a2) of
      GREATER => GREATER
    | EQUAL => EQUAL
    | LESS => LESS;


`

函数 SwapDown 是实现最小堆的关键函数，它的作用对一个最小堆加入一个数并且保持最小堆的性质。首先考虑树为空的情况，这时候直接返回树。然后考虑树的根节点的两个子节点都为空的情况，这时候直接返回树。最后考虑树的根节点的两个子节点都不为空的情况，这时候需要比较根节点和两个子节点的值，如果根节点的值小于两个子节点的值，那么直接返回树。如果根节点的值大于两个子节点的值，那么需要将根节点的值与两个子节点中较小的值交换，然后递归调用 SwapDown 函数，直到树的根节点的值小于两个子节点的值。实验代码如下：
`
fun SwapDown (Empty : tree) : tree = Empty
  | SwapDown (Br(Empty, a, Empty) : tree) = Br(Empty, a, Empty)
  | SwapDown (Br(t1 as Br(t11, a1, t12), a, Empty) : tree) =
    if treecompare(Br(t1,a,Empty), t1) = GREATER then
      Br(t1, a, Empty)
    else
      Br(Br(t11,a, t12), a1, Empty)
  | SwapDown (Br(Empty, a, t2 as Br(t21, a2, t22)) : tree) =
    if treecompare(Br(Empty, a, t2), t2) = LESS then
      Br(Empty, a,t2)
    else
      Br(Empty, a2, Br(t21,a,t22))
  | SwapDown (Br(t1 as Br(t11, a1, t12), a, t2 as Br(t21, a2, t22)) : tree) =
    if treecompare(Br(t1,a,t2),t1)=LESS andalso treecompare(Br(t1,a,t2),t2)=LESS then
      Br( t1, a,  t2)
    else if treecompare(Br(t1,a,t2),t1) = GREATER  then
      Br(Br(t11,a,t12), a1, t2)
    else
      Br(t1, a2, Br(t21,a,t22));


`


函数 heapify 是一个简单的函数，它的作业是将一个任意的树转换为最小堆。只需要不断对一个普通二叉树堆化直到每个节点都遍历过为止，返回的便是一个最小堆二叉树。实验代码如下：
`
fun heapify (Empty : tree) : tree = Empty
  | heapify (Br(t1, a, t2) : tree) =
    let
      val swappedT1 = heapify t1
      val swappedT2 = heapify t2
    in
      SwapDown (Br(swappedT1, a, swappedT2))
    end;


`


#pagebreak()
== 实验4.3 mapList
=== 实验要求

编写函数 mapList ，要求：
① 函数类型为: ((a -> b) \* a list) -> b list；
② 功能为实现整数集的数学变换(如翻倍、求平方或求阶乘)

编写函数 mapList2 ，要求：
① 函数类型为: (a -> b) -> (a list -> b list)；
② 功能为实现整数集的数学变换(如翻倍、求平方或求阶乘)。

=== 实验过程

对于 mapList ，因为函数入参是由变换函数 f 和待处理list a 构成的列表，而函数的值是关于结果 b 的list，所以需要对 a list 进行遍历，对每个元素进行函数 f 的运算，然后将结果放入结果 list b中。实验代码如下：
`
fun mapList (f, lst) =
    case lst of
        [] => []  (* 空列表返回空列表 *)
      | x::xs => f x :: mapList (f, xs);


`


对于 mapList2 ，它接受一个函数 f，该函数将 a 类型映射到 b 类型，以及一个 a list 类型的整数列表。它直接返回一个 b list 类型的新列表。它和 maplist的区别就在于它们接收的参数不同， maplist 接收映射关系和 a list构成的元组而 maplist2 直接接收映射关系和 a list。实验代码如下：
`
fun mapList2 f =
    let
        fun mapFn [] = []
          | mapFn (x::xs) = f x :: mapFn xs;
    in
        mapFn
    end;


`


#pagebreak()

== 实验4.4 exists
=== 任务描述

编写函数：
    exists: (int -> bool) -> int list -> bool
要求：对函数p: int -> bool, 整数集L: int list,有：

exist p L =>\* true if there is an x in L such that p x=true;

exits p L =>\* false otherwise.

=== 实验过程

根据题意函数 exists接受一个谓词函数 p 和一个整数列表 L，并检查列表中是否存在某个元素满足谓词 p，如果是，则返回 true，否则返回 false。我们可以通过递归遍历 list 得到函数的值，因此代码如下：
`
fun exists p [] = false  (* 如果列表为空，返回 false *)
  | exists p (x::xs) =
    if p x then true  (* 如果 p x 为 true，返回 true *)
    else exists p xs;  (* 否则继续在剩余的列表中查找 *)
`

#pagebreak()
= 课程建议和意见

老师很活泼上课互动很积极，课堂氛围很好，满分捏。
//== 图片

//除了排版，这个模板主要改进了图片、表格、公式的引用，编号以第x章来计算。


//图用下面的方式来引用，img 是对 image 的包装，caption 是图片的标题。

//#img(
//  image("assets/avatar.jpeg", height: 20%),
//  caption: "我的 image 实例 1",
//) <img1>
//
//引用的话就在 img 后加上标签<label>，使用 at 来引用即可，比如@img2 就是这么引用的。
//
//#img(
//  image("assets/avatar.jpeg", height: 20%),
//  caption: "我的 image 实例 2",
//) <img2>
//
//引用 2-1: @img1

//== 表格
//
//表格跟图片差不多，但是表格的输入要复杂一点，建议在 typst 官网学习，自由度特别高，定制化很强。
//
//看看@tbl1，tbl 也是接收两个参数，一个是 table 本身，一个是标题，table 里的参数，没有字段的一律是单元格里的内容（每一个被[]）包起来的内容，在 align 为水平时横向排列，排完换行。
//
//#tbl(
//  table(
//    columns: (100pt, 100pt, 100pt),
//    inset: 10pt,
//    stroke: 0.7pt,
//    align: horizon,
//    [], [*Area*], [*Parameters*],
//    image("assets/avatar.jpeg", height: 10%),
//    $ pi h (D^2 - d^2) / 4 $,
//    [
//      $h$: height \
//      $D$: outer radius \
//      $d$: inner radius
//    ],
//    image("assets/avatar.jpeg", height: 10%),
//    $ sqrt(2) / 12 a^3 $,
//    [$a$: 边长]
//  ),
//  caption: "芝士样表"
//) <tbl1>
//
//
//
//#tbl(
//  three_line_table(
//    (
//    ("Country List", "Country List", "Country List"),
//    ("Country Name or Area Name", "ISO ALPHA Code", "ISO ALPHA"),
//    ("Afghanistan", "AF", "AFT"),
//    ("Aland Islands", "AX", "ALA"),
//    ("Albania", "AL", "ALB"),
//    ("Algeria", "DZ", "DZA"),
//    ("American Samoa", "AS", "ASM"),
//    ("Andorra", "AD", "AND"),
//    ("Angola", "AP", "AGO"),
//  )),
//  caption: "三线表示例"
//)
//
//#tbl(
//  three_line_table(
//    (
//    ("Country List", "Country List", "Country List", "Country List"),
//    ("Country Name or Area Name", "ISO ALPHA 2 Code", "ISO ALPHA 3", "8"),
//    ("Afghanistan", "AF", "AFT", "7"),
//    ("Aland Islands", "AX", "ALA", "6"),
//    ("Albania", "AL", "ALB", "5"),
//    ("Algeria", "DZ", "DZA", "4"),
//    ("American Samoa", "AS", "ASM", "3"),
//    ("Andorra", "AD", "AND", "2"),
//    ("Angola", "AP", "AGO", "1"),
//  )),
//  caption: "三线表示例2"
//)
//
//
//== 公式
//
//公式用两个\$包裹，但是语法跟 LaTeX 并不一样，如果有大量公式需求建议看官网教程 https://typst.app/docs/reference/math/equation/。
//
//为了给公式编号，也依然需要封装，使用 equation 里包公式的方式实现，比如：
//
//#equation(
//  $ A = pi r^2 $,
//) <eq1>
//
//根据@eq1 ，推断出@eq2
//
//#equation(
//  $ x < y => x gt.eq.not y $,
//) <eq2>
//
//然后也有多行的如@eq3，标签名字可以自定义
//
//#equation(
//  $ sum_(k=0)^n k
//    &< 1 + ... + n \
//    &= (n(n+1)) / 2 $,
//) <eq3>
//
//
//如果不想编号就直接用\$即可
//
//
//$ x < y => x gt.eq.not y $
//
//== 列表
//
//- 无序列表1: 1
//
//- 无序列表2: 2
//
//#indent()列表后的正文，应当有缩进。这里加入一个 \#indent() 函数来手动生成段落缩进，是因为在目前的 typst 设计里，按英文排版的习惯，连续段落里的第一段不会缩进，也包括各种列表。
//
//1. 有序列表1
//2. 有序列表2
//
//列表后的正文，应当有缩进，但是这里没有，请自己在段首加上\#indent()
//
//想自己定义可以自己set numbering，建议用 \#[] 包起来保证只在该作用域内生效：
//
//#[
//#set enum(numbering: "1.a)")
//+ 自定义列表1
//  + 自定义列表1.1
//+ 自定义列表2
//  + 自定义列表2.1
//]
//
//#pagebreak()
//= 上机实验心得体会
//
//== 文献引用
//
//引用支持 LaTeX Bib 的格式，也支持更简单好看的 yml 来配置，在引用时使用#bib_cite("harry", "某本参考书")以获得右上的引用标注。
//
//
//记得在最后加入\#references("xxxref.yml")函数的调用来生成参考文献。
//
//*尚不支持国标，自定义参考文献功能官方正在开发中*
//
//== 致谢部分
//
//致谢部分在最后加入\#acknowledgement()函数的调用来生成。
//
//
//== 模板相关
//
//这个模板应该还不是完全版，可能不能覆盖到华科论文的所有case要求，如果遇到特殊 case 请提交 issue 说明，或者也可以直接提 pull request
//
//同时，由于 typst 太新了，2023年4月初刚发布0.1.0版本，可能会有大的break change发生，模板会做相应修改。
//
//主要排版数据参考来自 https://github.com/zfengg/HUSTtex 同时有一定肉眼排版成分，所以有可能不完全符合华科排版要求，如果遇到不对的间距、字体等请提交 issue 说明。
//
//=== 数据相关
//
//所有拉丁字母均为 Times New Roman，大小与汉字相同
//
//正文为宋体12pt，即小四
//
//图表标题为黑体12pt
//
//表格单元格内容宋体10.5pt，即五号
//
//一级标题黑体18pt加粗，即小二
//
//二级标题14pt加粗，即四号
//
//正文行间距1.24em（肉眼测量，1.5em与与word的1.5倍行距并不一样）
//
//a4纸，上下空2.5cm，左右空3cm
//
//#pagebreak()
//= 这是一章占位的

//== 占位的二级标题 1
//
//== 占位的二级标题 2
//
//== 占位的二级标题 3
//
//== 占位的二级标题 4
//
//=== 占位的三级标题 1
//
//=== 占位的三级标题 2
//
//==== 占位的四级标题 1
//
//==== 占位的四级标题 2
//
//== 占位的二级标题 5
//
//== 占位的二级标题 6
//
//


//#acknowledgement()[
//
//]
//


// #let references(path) = {
//   // 这个取消目录里的 numbering
//   set heading(level: 1, numbering: none)

//   set par(justify: false, leading: 1.24em, first-line-indent: 2em)

//   show bibliography: it => {
//     [= 参考文献]
//     let bib = yaml("./bibitems.yaml")
//     // let bib = yaml("arr.yaml")
//     let idx = 0
//     set par(leading: 1.24em)
//     grid(
//       columns: (1fr, 15fr),
//       row-gutter: 1.24em,
//       ..bib.enumerate().map(((idx, title)) => {
//         ([[#{idx+1}]], title)
//       }).flatten()
//     )
//   }
//   bibliography(path, title:"参考文献")
// }
//
//#references("./ref.yml")
//
#indent() //由于华科使用自创引用格式，基本上为 GB/T 7714 去掉[J]、[C]、[M] 等。所以需要用 show rule 来自定义格式，原理为读取自定义的 bibitems.
//yaml 文件再一项项渲染出来，因此要求自己维护顺序，使用时请取消 \#references() 前的注释。
