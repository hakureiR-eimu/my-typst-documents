#import "template.typ": *
#import "@preview/codelst:2.0.0": sourcecode
#import "@preview/tablem:0.1.0": tablem

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

// #figure(
//     grid(
//         columns: 2,     // 2 means 2 auto-sized columns
//         gutter: 2mm,    // space between columns
//         image("./assets/2-4.png", width: 80%),
//         image("./assets/2-4.png", width: 80%),
//     ),
//     caption: "some caption"
// )

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
// 1. 综合运用软件工程的思想，协同完成一个软件项目的开发，掌软件工程相关的技术和方法；
// 2. 组成小组进行选题，通过调研完成项目的需求分析，并详细说明小组成员的分工、项目的时间管理等方面。
// 3. 根据需求分析进行总体设计、详细设计、编码与测试等。

1. *问题概述、需求分析**：*正确使用相关工具和方法说明所开发软件的问题定义和需求分析，比如NABCD模型，Microsoft Visio，StarUML等工具 (20%)；
2. *原型系统设计、概要设计、详细设计：*主要说明所开发软件的架构、数据结构及主要算法设计，比如墨刀等工具（35%）；
3. *编码与测试：*编码规范，运用码云等平台进行版本管理，设计测试计划和测试用例（30%）；
4．*功能创新：*与众不同、特别吸引用户的创新（10%）；
5. *用户反馈：*包括用户的使用记录，照片，视频等（5%）。




#pagebreak()

= 问题定义
== 项目背景与意义

=== 项目背景

“众人拾柴火焰高”，集思广益，有助于提高群体的效率；“兼听则明，偏听则暗”，他人的意见也会带给我们新的启迪和思考。随着社会不断发展，人们在社会生活中的议论和参与变得更加丰富多样。

进入信息时代，互联网论坛成为人们交流意见的新平台。近年来，前台匿名聊天论坛的兴起为网络交流注入新的活力。目前，许多高校学生主动创建了匿名聊天论坛，例如“树洞”，然而，这些树洞也暴露出一系列值得关注的问题。例如，管理员难以有效监管可能出现的违法违规内容；系统开发不够完善，存在用户数据泄露的潜在风险；在高流量场景下，服务可能崩溃，而且论坛形式相对单一等。

#img(
 image("./assets/2-1.png", width: 80%),
 caption: ["国内某大学树洞网页"],
)
// [
//     A step in the molecular testing
//     pipeline of our lab.
//   ],
  // #image("image.png")
     由此可见，目前我们高校“树洞”需要的软件应满足以下的需求：易于管理员管理；数据安全性、可靠性高；提供比较完善的匿名机制，让同学们在不违法违规的前提下畅所欲言。

=== 项目意义

项目的意义在于迎合背景中提到的需求、解决部分现存问题，并优化高校匿名聊天论坛的体验。首先，创建一个易于管理员管理的平台可以更有效地监督内容，确保论坛的讨论既自由又合规。其次，提升数据安全性和可靠性至关重要，以保护用户的隐私和避免数据泄露。此外，完善的匿名机制可以鼓励更多学生参与讨论，分享他们的想法和经验，而不必担心个人信息泄露或遭受偏见。这样，论坛不仅能成为一个表达和交流的空间，也能成为学习和成长的平台。

通过这个项目，我们不仅可以提升高校社区的交流质量，还能促进知识和经验的共享，帮助学生们在学术和个人成长方面得到更好的支持。此外，改进的论坛还可以成为处理紧急情况和提供心理健康支持的重要资源。总的来说，这个项目的意义在于创造一个更安全、更包容、更高效的线上交流环境。

== 项目基本目标

通过深入研究现实论坛中帖子的发布、浏览、评论及删除等环节，我们计划开发一款基于Tailwind css、Vuejs、Spring boot及Mysql技术的前后端分离Web应用。该应用不仅旨在便利论坛管理员对各类帖子信息的有效管理，而且着眼于为用户提供便捷、安全的帖子获取体验，保障个人信息的安全，并支持自由发表评论。我们的目标是为同学们提供一个既适合休闲上网，又能进行学术交流和生活分享的平台，同时配备严密的隐私保护机制，以确保一个安全、包容、互动丰富的在线社区环境。

== 可行性分析

通过以上对项目背景、项目意义和项目基本目标的考察研究，并结合自身能
力、项目开发平台等因素进行考量，最终可以从一下几个方面分析项目的可行性：
=== 技术难度

本次项目基于前后端分离进行Web APP的开发工作，前端主要使用Tailwind Css构建网页布局，用JS + Vue框架编写页面变换逻辑，后端主要使用Spring Boot框架，使用Spring MVC进行Web开发，MySQL作为数据库，MyBatis-Plus作为数据访问框架，并基于Java 17。数据以JSON形式在前端和后端之间传送。负责前端的同学和负责后端的同学都有一定程度的相关技术基础。

在图形界面方面，Tailwind CSS为开发者提供了丰富的系统控件，使得我们可以很轻松的编写出漂亮的界面。在数据存储方面，我们选用Mysql这种经典的关系数据库存储数据。它不仅支持标准的 SQL 语法，还提供了java/js API 进行操作，让存储和读取数据变得非常方便。

综上，系统在技术方面是可行的。

#img(
    grid(
        columns: 3,     // 2 means 2 auto-sized columns
        gutter: 2mm,    // space between columns
        image("./assets/2-vue.png", width: 80%),
        image("./assets/2-tail.png", width: 80%),
        image("./assets/2-Sp.png", width: 80%),
    ),
    caption: "项目技术栈: Vue, Tailwind Css, Spring Boot..."
)

// #image("image.png")
// #image("image.png"2
// #image("image.png")
=== 市场需求

根据市场情况、口头调查结果和 NABCD 模型分析可以得出，“树洞”论坛有着比较广阔的应用场景，很受青年学生欢迎。 从用户需求上看，很多同学希望能有一个匿名的、氛围友好的网上论坛，用于课余时间的交流和讨论。

从市场竞争上看，目前大部分“树洞”和网上匿名论坛有提供的服务不够完善、部分用户发言不友善，导致管理困难、用户隐私信息安全性不高等，因此我们的项目有很大的竞争力。在产品推广上，我们可以借助校内自媒体传播、在学生宿舍门口张贴海报宣传等，还可以和校心理协会等组织合作，帮助情绪上处于低谷的同学走出困境。

#img(
 image("./assets/2-5.png", width: 80%),
 caption: ["‘树洞’引发的社会关注"],
)
// #image("image.png")

// #image("image.png")
// #image("image.png")

=== 开发成本

1.人力成本
本次项目工作量稍大，因而有一定的开发成本，但考虑到开发小组有三名成员，部分成员有Web开发技术基础，因而人力成本在可以接受的范围内。在时间成本上，虽然开发设计的部分技术同学们前期学习了解不多，但网络上可以搜到丰富的学习资料等，因而初期学习所需要的时间成本也不会很多，小组成员每周进行几个到十几个小时的代码工作最终可以完成开发任务。


2.经济成本：
本项目计划采用开源框架和开源工具，经济成本花费很小；对于可能需要付费的visio等绘图软件，利用学校提供的正版软件许可，不需要额外的开销。后期如果要部署到有公网IP的服务器上，可能需要向学校申请校园网公网IP，或者通过云服务器提供服务，也仅需要很少的运维花费。此外，本次软件开发中，编写、测试代码的硬件设备使用同学们自己的个人笔记本，不需要购置额外的硬件设备。从这些观察中可以看出：在本项目的整个周期内，花费的经济成本非常小。


== 人员管理和项目进度管理

=== 人员分工

我们首先对项目的总体任务进行分工。我们要实现的是一个前后端分离的“树洞”系统，所以任务首先可以分为前端和后端两个部分。综合考虑小组成员技术积累、时间投入和技术兴趣因素，我们初步决定：马耀辉同学负责后端任务，夏彦文和张钧炜同学负责前端任务。前端任务继续细分成两部分：网页代码部分和前端代码部分。这两个部分还可以再做拆解，如下图所示。

如下图所示，任务共可以被拆分成几个阶段。每个阶段内的前后端任务可以并行，从而充分提高开发效率。

=== 源代码管理

首先，我们在Github平台上建立了一个组织，在这个组织下面建立了仓库，如下图所示。
// #image("image.png")

#img(
 image("./assets/2-2.png", width: 80%),
 caption: ["Github平台上的组织和仓库"],
)
// #image("./assets/2-2.png")

在仓库中，我们根据个人分工的不同创建了多个不同的分支，分支命名规范为"人名缩写/分工"。我们在不同的分支上开发，完成到一定程度时合并分支到该分工的开发分支，最终合并到master分支。对于Commit信息，我们也严格遵照规范，增强了可读性，如下图所示。

#img(
 image("./assets/2-3.png", width: 80%),
 caption: ["各项任务的开发分支"],
)

#img(
 image("./assets/2-4.png", width: 80%),
 caption: ["规范提交记录"],
)
// #image("image.png")
// #figure(
//     grid(
//         columns: 2,     // 2 means 2 auto-sized columns
//         gutter: 2mm,    // space between columns
//         image("./assets/2-4.png", width: 80%),
//         image("./assets/2-4.png", width: 80%),
//     ),
//     caption: "some caption"
// )

=== 进度管理

在项目开发前期我们每隔四五天左右开一次小组会议，确定了设计目标，分析了可行性；项目开发中期、后期，我们在群聊里及时共享进度、互相询问技术问题，保证了进度良好、有序推进。

#img(
 image("./assets/2-schedule.png", width: 80%),
 caption: ["工期安排"],
)
// #image("image.png")

我们在分支提交信息里明确写出进度，小组成员先查看Github上的提交记录，就清楚了大部分任务的进度情况。

#img(
 image("./assets/2-ganti.png", width: 100%),
 caption: ["进度管理-甘特图"],
)
// #image("image.png")

#pagebreak()



= 需求分析
// == 后端
==  需求分析概述

- N（需求） 
在日常生活中，学生面临着各式各样的压力和挑战，往往缺乏合适的倾诉对象或在某些情况下不便于实名分享自己的感受和想法。这种背景下，建立一个能够提供匿名交流的在线平台变得尤为重要。我们计划开发的“树洞”平台，旨在满足这一需求，提供一个安全、匿名的环境，使同学们能够在放松和支持的氛围中交流，分享日常生活中的压力和经历，同时也强化了同学间的联系。

- A（方法）
该平台将包含用户登录、发帖、回帖等基本功能。所有用户的真实信息将被安全地保存在后端数据库中，而用户在前台的活动如发帖和回帖将保持匿名。这种设计不仅能够根据用户的权限级别展示不同的帖子，还能提供诸如发帖、回帖、删除帖子等功能，确保用户在享受交流自由的同时，其个人信息得到妥善保护。

- B（好处）
此平台的主要好处在于为同学们提供了一个安全、自由的交流空间。通过前台匿名的方式，用户可以自由地发帖和回帖，同时平台能够有效监控并排查发布违法或违规内容的账号信息。此外，通过用户权限的隔离，进一步保证了用户个人隐私的安全。这样的设计也使得平台更易于管理和维护。

- C（竞争）
与其他类似的“树洞”软件相比，我们的平台提供了更自由、更即时、更轻量化的内容访问和发布功能。许多现有的树洞平台在处理违法或违规信息方面存在不足，而我们的系统通过后端数据库的维护，能够更有效地进行删帖、封号等管理活动，从而提供一个更安全、更负责任的交流环境。

- D（推广）
为了推广我们的平台，我们计划在学校的交流群组中进行宣传，并与院系学生组织合作，通过这些组织的网络和资源进行有效推广。通过这种方式，我们能够直接接触到潜在的用户群体，从而提高平台的知名度和使用率。







// 同学们在日常生活中，会遇到各种各样的压力和困难，有时候身边没有合适的倾诉对象、或者不方便实名倾诉。为了加强同学们之间的交流与联系，在紧张的生活之余在网络上得到放松，我们制作一个匿名的在线平台“树洞”，允许同学们匿名发帖回帖交流。

// - A（方法） 
// 平台涉及用户登录、发帖等功能。用户真实信息和帖子信息保存在后端数据库中，根据用户的权限级别展示帖子，并提供发帖、回帖、删帖等功能。采取前台匿名的方式实现匿名。
// - B（好处） 
// 同学们可以匿名回帖发帖，自由交流；由于采取前台匿名，可以有效排查发布违法违规内容的账号信息；用户权限隔离，保证用户个人的隐私得到保护。
// 便于管理。
// - C（竞争） 
// 相对其他树洞软件，提供更自由、更即时、更轻量化的内容访问和发布功能；此外，目前大部分树洞平台面对违法违规信息不能有效打击，我们的系统通过查后端数据库的方式进行删帖封号等
// - D（推广） 
// 可以在学校交流群里进行推广；与院系学生组织合作推广等。


== UML相关需求分析图

// #image("image.png")
#img(
 image("./assets/3-uml2.png", width: 100%),
 caption: ["UML需求分析"],
)

我们系统的UML需求分析图如上图所示。在这张图中，我们看到了两类主要的参与者：普通用户和管理员，以及他们可以执行的操作。

该用例图详细描述了树洞论坛系统中用户和管理员的交互活动。普通用户的活动包括注册和登录，这是访问论坛的先决条件。一旦进入系统，用户可以浏览帖子来获取信息，或使用搜索功能来定位特定的内容。用户互动的核心在于发帖和回帖，这些操作为社区的沟通提供了基础。此外，用户还可以编辑或删除自己的帖子，这样的功能保障了他们可以控制自己在论坛上的信息和隐私。

管理员在登录后获得的权限更为广泛，涵盖了帖子的全面管理。他们不仅可以浏览所有帖子以监督论坛活动，还能进行帖子的审核和删除，确保论坛内容的质量和适宜性。管理活动还包括用户账户的管理，管理员可以对用户的活动进行必要的监控和制裁。

在图中，用虚线和“include”标签表示的关系表明某些活动是其他活动的必要部分。例如，发帖通常会“include”编辑帖子的功能。整体上，这个用例图提供了一个清晰的视图，描绘了树洞论坛系统中的角色和他们可以执行的操作，以及这些操作之间的依赖关系。
// #image("image.png")

== 数据流分析图

在系统中，用户和管理员是主要的参与者，他们与系统的不同功能进行交互。下面是对下图展示的每部分的详细解释：

- *用户（User）:*

  用户是系统的主要操作者之一。他们可以进行多种操作，如发布帖子、浏览帖子、评论、个人信息编辑、查看通知等。

- *管理员（Admin）:*

  管理员是具有特殊权限的操作者。他们负责管理帖子，包括删除帖子和审核帖子内容，以确保内容的合理性和适宜性。

- *系统功能:*

  发布帖子: 用户创建并发布新的讨论帖。
  浏览帖子: 用户和管理员查看论坛上的帖子。
  评论: 用户对帖子添加评论。
  个人信息编辑: 用户更新他们的个人账户信息，如密码、电子邮件地址等。
  查看通知: 用户接收系统消息和帖子更新通知。
  帖子管理: 管理员对帖子进行审核和管理。

- *数据存储:*

  用户数据库: 存储用户个人信息的数据库。帖子数据库: 存储帖子和评论的数据库。

- *数据流:*

  数据流向从用户和管理员指向不同的系统功能，表示信息的输入或操作的请求。反向的数据流向表示系统对操作的响应，如返回浏览结果、通知信息、管理结果等。

#img(
 image("./assets/dataflow-1.png", width: 100%),
 caption: ["数据流分析图"],
)

== 系统ER图
#img(
 image("./assets/ER.png", width: 70%),
 caption: ["系统ER图"],
)

ER图主要包含三个实体：用户、帖子和评论。每个实体都有其唯一的属性和标识符。

用户实体代表论坛的注册成员，它包含了用户的基本信息。每个用户都有一个唯一的ID，这是他们在系统中的唯一标识。除此之外，用户实体还包含姓名、密码和账号信息。姓名用于标识用户的真实或昵称，密码用于登录验证（在实际存储时需要加密），而账号可能是用户的电子邮件地址或学号，用于登录和用户识别。

帖子实体代表用户在论坛上发布的内容。每个帖子都有一个唯一的ID，以及包含其详细信息的文本内容和创建时间戳。帖子的内容是用户交流和分享信息的主体，创建时间则记录了帖子发布的具体时间。

评论实体是对帖子的回应。与帖子类似，每个评论都有一个唯一的ID，内容和创建时间。评论允许用户对帖子内容进行讨论和回复，增加了论坛的互动性。

在这些实体之间，存在几种关键的关系：

（1）用户和帖子之间的关系表明用户可以发布多个帖子。这是一个一对多的关系，其中单个用户可能关联多个帖子。

（2）用户和评论之间的关系也是一对多的，表示用户可以对多个帖子进行评论。

（3）帖子和评论之间的关系指出一个帖子可以有多个评论。这也是一个一对多的关系，表明论坛的帖子可以引发讨论，吸引多个评论。

在实际的数据库实现中，这些实体将转换为数据库表，属性将成为表中的列，实体间的关系将通过外键或关系表来实现。这样的结构设计确保了数据的组织和管理既系统又高效。

#img(
 image("./assets/Arch.png", width: 80%),
 caption: ["系统架构图"],
)
// #image("assets/Arch.png")
// #image("image.png")
// == 原型系统设计
// == 前端
// == 需求分析概况
// == UML相关需求分析图
== 原型系统设计

对于树洞论坛系统，原型设计将包括以下关键界面和功能：

用户注册与登录界面：设计一个直观的注册页面，让新用户能够方便地创建账户，并提供一个登录页面，使得回访用户可以轻松进入论坛。

首页与帖子浏览界面：创建一个清晰的首页，展示最新或最热门的帖子列表，以及一个导航系统，允许用户根据帖子类别或关键词进行搜索和筛选。

帖子发布界面：提供一个用户友好的帖子编辑器，让用户可以编写和发布新帖子。编辑器应包括基本的文本格式工具和附件上传功能。

评论互动界面：确保帖子下方有一个区域供用户留下评论，并互动。用户应能够轻松回复他人的评论，从而促进社区内的讨论。

用户个人资料界面：允许用户查看和编辑他们的个人资料信息，如用户名、密码、联系方式等。

管理员管理界面：为管理员提供一个强大的控制面板，用于帖子审核、用户管理、统计信息查看和论坛设置等。

以下是部分原型设计界面：
#img(
  image("assets/loginPage.png"),
  caption:"登录界面"
)
#img(
  image("assets/postPage.png"),
  caption:"首页"
)
#img(
  image("assets/commentChartPage.png"),
  caption:"评论页及互动页"
)
#pagebreak()
= 概要设计和详细设计
== 后端

该项目采用了Spring Boot作为基础框架，Spring Boot是一个用于简化Spring应用程序开发的框架。它通过提供默认的配置和约定大于配置的方式，使得快速构建独立、可执行的、生产级别的Spring应用程序变得更加容易。

在Web开发方面，该项目使用了Spring MVC框架。Spring MVC是基于MVC（Model-View-Controller）设计模式的Java Web框架，它提供了处理请求和响应的机制，可以用于构建RESTful风格的Web应用程序。

数据库访问方面，该项目使用了MySQL作为数据库，并结合了MyBatis-Plus框架进行数据访问。MyBatis-Plus是一个增强版的MyBatis框架，它提供了更多的功能和便利的开发特性，如通用CRUD操作、分页查询、乐观锁支持等。在该项目中，数据库托管在华为云服务器上。华为云提供了强大的云计算平台，其中包括云服务器实例。通过将数据库部署在华为云服务器上，便于统一数据，方便组内开发项目。

另外，该项目使用了Java 17作为项目的Java版本。Java 17是Java编程语言的一种稳定版本，它提供了许多新的特性和改进，可以用于编写高效、现代化的Java应用程序。

总结起来，该项目采用了Spring Boot作为基础框架，使用Spring MVC进行Web开发，MySQL作为数据库，MyBatis-Plus作为数据访问框架，并基于Java 17进行开发。这些技术和工具的结合使得项目开发更加便捷和高效。

=== 环境

依赖描述：

1. spring-boot-starter-web：这是一个Spring Boot的起步依赖，用于开发Web应用程序。它包含了常用的Web开发所需的依赖和配置。
2. spring-boot-devtools：这是一个开发工具，用于在开发过程中实现热部署和自动重启应用程序的功能。它提供了一些开发时的便利功能，如自动编译、重新加载等。
3. mysql-connector-j：这是MySQL数据库的官方Java驱动程序，用于在Java应用程序中连接和操作MySQL数据库。
4. spring-boot-configuration-processor：这个依赖用于处理Spring Boot应用程序中的配置文件，并生成相关的元数据，以便在IDE中进行代码提示和补全。
5. lombok：这是一个Java库，用于简化Java代码的编写。它提供了一些注解和工具，可以自动生成一些常用的代码，如getter和setter方法、构造函数等。
6. spring-boot-starter-test：这是一个用于编写和运行测试的Spring Boot起步依赖。它包含了常用的测试框架和工具，如JUnit、Mockito等。
7. mybatis-plus-boot-starter：这是MyBatis-Plus的Spring Boot起步依赖，用于集成MyBatis-Plus框架到Spring Boot应用程序中。MyBatis-Plus是一个增强版的MyBatis框架，提供了更多的功能和便利的开发特性。
8. mybatis-plus-annotation：这是MyBatis-Plus的注解模块，提供了一些基于注解的开发特性，如注解查询、注解更新等。
9. mybatis-plus-extension：这是MyBatis-Plus的扩展模块，提供了一些额外的功能和扩展点，如自定义SQL注入器、自定义全局配置等。
10. mybatis-plus：这是MyBatis-Plus的核心模块，包含了基本的MyBatis-Plus功能和API。

环境描述：

1. Java版本：该项目使用Java 17进行开发和编译。
2. Spring Boot版本：该项目使用Spring Boot 2.7.16作为基础框架。
3. Maven：该项目使用Maven作为构建工具。

此外，还有一个针对Spring Boot的Maven插件配置。该插件是用于将项目打包成可执行的JAR文件，并提供了一些Spring Boot相关的功能和配置。在这个POM文件中，使用了spring-boot-maven-plugin插件，并配置了排除项目中的lombok依赖，以避免在打包过程中将lombok的相关代码包含进去。

=== 工程配置

1. MybatisPlusConfig.java:

#sourcecode[```java
@Configuration
@Slf4j
public class MybatisPlusConfig {

    /**
     * MybatisPlus插件配置
     * @return {@link MybatisPlusInterceptor }
     */
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        //分页插件
//        interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL));
        PaginationInnerInterceptor paginationInnerInterceptor = new PaginationInnerInterceptor(DbType.MYSQL);
        // 处理查询溢出，当超过最大页数时不会报错
        paginationInnerInterceptor.setOverflow(true);
        interceptor.addInnerInterceptor(paginationInnerInterceptor);
        //防止全表更新与删除
        interceptor.addInnerInterceptor(new BlockAttackInnerInterceptor());
        return interceptor;
    }


    /**
     * 表对应的实例，自动填充创建时间和更新时间
     *
     * @return {@link MetaObjectHandler}
     */
    @Bean
    public MetaObjectHandler metaObjectHandler() {
        return new MetaObjectHandler() {
            @Override
            public void insertFill (MetaObject metaObject){
                log.info("auto fill------[insert]");
                metaObject.setValue("registerDate", LocalDateTime.now());
                metaObject.setValue("loginDate", LocalDateTime.now());
                metaObject.setValue("postDate", LocalDateTime.now());
                metaObject.setValue("commentDate", LocalDateTime.now());
            }

            @Override
            public void updateFill (MetaObject metaObject){
                log.info("auto fill------[update]");
                metaObject.setValue("loginDate", LocalDateTime.now());
            }
        };
    }

}
```]

这是一个使用Mybatis Plus框架的配置类。

通过mybatisPlusInterceptor()方法，配置了Mybatis Plus的插件拦截器。其中包括了分页插件（PaginationInnerInterceptor）、防止全表更新与删除的插件（BlockAttackInnerInterceptor）。

通过metaObjectHandler()方法，配置了表对应的实例的自动填充功能。在插入数据时，自动填充创建时间（registerDate、loginDate、postDate、commentDate）；在更新数据时，自动填充登录时间（loginDate）。

2. WebConfiguration.java:

#sourcecode[```java
@Configuration
public class WebConfiguration implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new AuthInterceptor())
                //  "/**" 表示所有请求路径都拦截，包含静态资源
                .addPathPatterns("/**")
                //放行的路径
                .excludePathPatterns("/css/**", "/img/**", "/js/**", "/error/**", "/zui/**", "/login");
    }
}

```]

这是一个Web配置类，实现了WebMvcConfigurer接口。

通过addInterceptors()方法，配置了拦截器（AuthInterceptor）。该拦截器用于对所有请求路径进行拦截，但排除了一些静态资源路径和登录路径。

3. application.yaml:

#sourcecode[```yaml
spring:
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    password: root
    url: jdbc:mysql://1.94.32.182:3306/carrot_hole?serverTimezone=UTC&useSSL=false
    username: root
mybatis-plus:
  type-aliases-package: com.hust23se.carrothole.entity #实体类取别名
  configuration:
    map-underscore-to-camel-case: true
mybatis:
  type-aliases-package: com.hust23se.carrothole.entity #实体类取别名
#  configuration:
#    ## 下划线转驼峰配置
#    map-underscore-to-camel-case: true
  mapper-locations: classpath:mapper/*.xml
  config-location: classpath:mybatis-config.xml
logging:
  level:
    root: info
    com.hust23se.carrothole: debug
  file:
    path: logs
server:
  port: 8080

```]

这是一个YAML格式的配置文件，包含了Spring Boot应用的各种配置项。

在spring.datasource下配置了数据库相关信息，包括数据库驱动类、URL、用户名和密码。

在mybatis-plus和mybatis下配置了Mybatis和Mybatis Plus的相关配置项，如实体类别名、映射文件路径等。

在logging下配置了日志级别和日志文件的路径。

在server下配置了应用的端口号。

以上是对后端工程配置文件的详细描述。这些配置文件用于配置数据库、Mybatis Plus、拦截器和其他应用相关的设置，以保证后端工程的正常运行和功能实现。

=== 系统结构

#img(
 image("./assets/class-dependency.png", width: 100%),
 caption: [后端类依赖图],
)

#img(
 image("./assets/src.png", width: 120%),
 caption: [后端系统结构图],
)

1. Config（配置）:

  - com.hust23se.carrothole.config.MybatisPlusConfig：这个类是Mybatis Plus框架的配置类，用于配置Mybatis Plus的插件和自动填充功能。
  - com.hust23se.carrothole.config.WebConfiguration：这个类是Web配置类，用于配置拦截器和静态资源路径的映射。
2. Controller（控制器）:
  
  - com.hust23se.carrothole.controller.AuthController：这个类是处理认证相关请求的控制器。
  - com.hust23se.carrothole.controller.CommentController：这个类是处理评论相关请求的控制器。
  - com.hust23se.carrothole.controller.PostController：这个类是处理帖子相关请求的控制器。
3. Entity（实体）:

  - com.hust23se.carrothole.entity.Comment：这个类是评论实体类，用于表示系统中的评论信息。
  - com.hust23se.carrothole.entity.Post：这个类是帖子实体类，用于表示系统中的帖子信息。
  - com.hust23se.carrothole.entity.User：这个类是用户实体类，用于表示系统中的用户信息。
4. Mapper（数据访问层）:

  - com.hust23se.carrothole.mapper.CommentMapper：这个类是评论的数据访问层接口，用于定义与评论数据相关的数据库操作。
  - com.hust23se.carrothole.mapper.PostMapper：这个类是帖子的数据访问层接口，用于定义与帖子数据相关的数据库操作。
  - com.hust23se.carrothole.mapper.UserMapper：这个类是用户的数据访问层接口，用于定义与用户数据相关的数据库操作。
5. Service（业务逻辑层）:

  - com.hust23se.carrothole.service.AuthService：这个类是认证服务接口，定义了与认证相关的业务逻辑。
  - com.hust23se.carrothole.service.AuthServiceImpl：这个类是认证服务的实现类，实现了AuthService接口的具体业务逻辑。
  - com.hust23se.carrothole.service.CommentService：这个类是评论服务接口，定义了与评论相关的业务逻辑。
  - com.hust23se.carrothole.service.CommentServiceImpl：这个类是评论服务的实现类，实现了CommentService接口的具体业务逻辑。
  - com.hust23se.carrothole.service.PostService：这个类是帖子服务接口，定义了与帖子相关的业务逻辑。
  - com.hust23se.carrothole.service.PostServiceImpl：这个类是帖子服务的实现类，实现了PostService接口的具体业务逻辑。
  - com.hust23se.carrothole.service.UserService：这个类是用户服务接口，定义了与用户相关的业务逻辑。
  - com.hust23se.carrothole.service.UserServiceImpl：这个类是用户服务的实现类，实现了UserService接口的具体业务逻辑。

这些类组成了系统的基本结构，用于实现用户认证、评论管理和帖子管理等功能。控制器负责接收和处理请求，服务层负责处理业务逻辑，数据访问层负责与数据库交互，实体类用于表示系统中的数据对象。通过这种结构，实现了系统的分层架构和业务逻辑的解耦，提高了系统的可维护性和可扩展性。

=== 接口声明
1. AuthController
#sourcecode[```java
@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    AuthServiceImpl authService;

    @PostMapping("/register")
    public boolean register(@RequestBody Map<String,Object> idMap) throws Exception {
        try{
            return authService.register(String.valueOf(idMap.get("userName")),String.valueOf(idMap.get("password")));
        }catch (Exception e){
            throw new Exception("register error");
        }
    }

    @PostMapping("/login")
    public ResultMap login(@RequestBody Map<String,Object> idMap) throws Exception{
        try{
            User user = authService.login(String.valueOf(idMap.get("userName")),String.valueOf(idMap.get("password")));
            ResultMap resultMap = ResultMap.create();
            if(user != null){
                resultMap.setSuccess();
                resultMap.setSuccessMsg("Login success");
                resultMap.setKeyValue("user", user);
            }else{
                resultMap.setError();
                resultMap.setErrorMsg("Login failed");
            }

            return resultMap;
        }catch (Exception e){
            throw new Exception("login error");
        }
    }
}
```]

该控制器类使用\@RequestMapping("/auth")注解来映射根URL路径，即所有该控制器处理的请求都应该以/auth开头。

下面是该控制器类中的两个请求处理方法：

- register方法：

  使用\@PostMapping("/register")注解将该方法映射到/auth/register路径的POST请求。
  
  该方法接受一个Map\<String, Object>类型的请求体（通过\@RequestBody注解），其中包含了用户名和密码信息。
  
  方法内部调用了一个名为authService的AuthServiceImpl对象的register方法，将用户名和密码作为参数传递给它。
  
  如果register方法返回true，则表示注册成功，该方法将返回true作为响应。
  
  如果register方法抛出异常，则将异常信息封装为Exception对象并抛出。
  
- login方法：

  使用\@PostMapping("/login")注解将该方法映射到/auth/login路径的POST请求。
  
  该方法接受一个Map\<String, Object>类型的请求体（通过\@RequestBody注解），其中包含了用户名和密码信息。
  
  方法内部调用了一个名为authService的AuthServiceImpl对象的login方法，将用户名和密码作为参数传递给它。
  
  如果login方法返回一个非空的User对象，表示登录成功。
  
  在登录成功的情况下，该方法创建了一个ResultMap对象，并设置了成功的状态码和消息，并将User对象作为值存储在ResultMap中的user键下。
  
  在登录失败的情况下，该方法创建了一个ResultMap对象，并设置了错误的状态码和消息。
  
  最后，该方法将创建的ResultMap对象作为响应返回。
  
  如果login方法抛出异常，则将异常信息封装为Exception对象并抛出。

2. PostController
#sourcecode[```java
@RestController
@RequestMapping("/post")
public class PostController {

    @Autowired
    PublishPostServiceImpl publishPostService;

    @Autowired
    PostServiceImpl postService;

    @PostMapping("/publish")
    public ResultMap publishPost(@RequestBody Map<String,Object> idMap) throws Exception {
        try{
            if(publishPostService.publishPost(String.valueOf(idMap.get("postTitle")),String.valueOf(idMap.get("postContent")),String.valueOf(idMap.get("userId")))){
                return ResultMap.create().setSuccess().setSuccessMsg("publish success");
            }
            return ResultMap.create().setError().setErrorMsg("publish failed");
        }catch (Exception e){
            throw new Exception("publish post error");
        }
    }

    @PostMapping("/get")
    public ResultMap getPost(@RequestBody Map<String,Object> idMap) throws Exception{
        try{
            Post post = postService.getById(String.valueOf(idMap.get("postId")));
            if(post == null){
                return ResultMap.create().setError().setErrorMsg("Not found");
            }else{
                return ResultMap.create().setSuccess().setSuccessMsg("Success").setKeyValue("post",post);
            }
        }catch (Exception e){
            throw new Exception("get post error");
        }
    }

    @PostMapping("/search")
    public ResultMap searchPost(@RequestBody Map<String,Object> idMap) throws Exception {
        try{
            Post post = postService.getPostByTitle(String.valueOf(idMap.get("postTitle")));
            if(post == null){
                return ResultMap.create().setError().setErrorMsg("Not found");
            }else{
                return ResultMap.create().setSuccess().setSuccessMsg("Success").setKeyValue("post",post);
            }
        }catch (Exception e){
            throw new Exception("search post error");
        }
    }

    @GetMapping("/getPostList")
    public ResultMap getPostList() throws Exception{
        try{
            List<Post> postList= postService.list();
            return ResultMap.create().setSuccess().setSuccessMsg("Success").setKeyValue("postList",postList);
        }catch (Exception e){
            throw new Exception("search post list error");
        }
    }

    @PostMapping("/getMyPost")
    public ResultMap getMyPost(@RequestBody Map<String,Object> idMap) throws Exception{
        try{
            List<Post> postList= postService.getPostByUserId(String.valueOf(idMap.get("userId")));
            return ResultMap.create().setSuccess().setSuccessMsg("Success").setKeyValue("postList",postList);
        }catch (Exception e){
            throw new Exception("search post list error");
        }
    }
}

```]

该控制器类使用\@RequestMapping("/post")注解来映射根URL路径，即所有该控制器处理的请求都应该以/post开头。

下面是该控制器类中的几个请求处理方法：

- publishPost方法：

  使用\@PostMapping("/publish")注解将该方法映射到/post/publish路径的POST请求。
  
  该方法接受一个Map\<String, Object>类型的请求体（通过\@RequestBody注解），其中包含了发布帖子所需的标题、内容和用户ID信息。
  
  方法内部调用了一个名为publishPostService的PublishPostServiceImpl对象的publishPost方法，将标题、内容和用户ID作为参数传递给它。
  
  如果publishPost方法返回true，表示发布成功，该方法将返回一个包含成功状态和消息的ResultMap对象。
  
  如果publishPost方法返回false，表示发布失败，该方法将返回一个包含错误状态和消息的ResultMap对象。
  
  如果publishPost方法抛出异常，则将异常信息封装为Exception对象并抛出。

- getPost方法：

  使用\@PostMapping("/get")注解将该方法映射到/post/get路径的POST请求。
  
  该方法接受一个Map\<String, Object>类型的请求体（通过\@RequestBody注解），其中包含了需要获取的帖子的ID信息。
  
  方法内部调用了一个名为postService的PostServiceImpl对象的getById方法，将帖子ID作为参数传递给它。
  
  如果getById方法返回一个非空的Post对象，表示获取成功。
  
  在获取成功的情况下，该方法创建了一个ResultMap对象，并设置了成功的状态码和消息，并将Post对象作为值存储在ResultMap中的post键下。
  
  在获取失败的情况下，该方法创建了一个ResultMap对象，并设置了错误的状态码和消息。
  
  最后，该方法将创建的ResultMap对象作为响应返回。
  
  如果getById方法抛出异常，则将异常信息封装为Exception对象并抛出。

- searchPost方法：

  使用\@PostMapping("/search")注解将该方法映射到/post/search路径的POST请求。
  
  该方法接受一个Map\<String, Object>类型的请求体（通过\@RequestBody注解），其中包含了需要搜索的帖子的标题信息。
  
  方法内部调用了一个名为postService的PostServiceImpl对象的getPostByTitle方法，将帖子标题作为参数传递给它。
  
  如果getPostByTitle方法返回一个非空的Post对象，表示搜索成功。
  
  在搜索成功的情况下，该方法创建了一个ResultMap对象，并设置了成功的状态码和消息，并将Post对象作为值存储在ResultMap中的post键下。
  
  在搜索失败的情况下，该方法创建了一个ResultMap对象，并设置了错误的状态码和消息。
  
  最后，该方法将创建的ResultMap对象作为响应返回。
  
  如果getPostByTitle方法抛出异常，则将异常信息封装为Exception对象并抛出。

- getPostList方法：

  使用\@GetMapping("/getPostList")注解将该方法映射到/post/getPostList路径的GET请求。

  该方法不接受请求体，直接返回帖子列表。
  
  方法内部调用了一个名为postService的PostServiceImpl对象的list方法，获取所有帖子的列表。
  
  如果list方法返回一个非空的帖子列表，表示获取成功。
  
  在获取成功的情况下，该方法创建了一个ResultMap对象，并设置了成功的状态码和消息，并将帖子列表作为值存储在ResultMap中的postList键下。
  
  在获取失败的情况下，该方法创建了一个ResultMap对象，并设置了错误的状态码和消息。
  
  最后，该方法将创建的ResultMap对象作为响应返回。
  
  如果list方法抛出异常，则将异常信息封装为Exception对象并抛出。

- getMyPost方法：

  使用\@PostMapping("/getMyPost")注解将该方法映射到/post/getMyPost路径的POST请求。
  
  该方法接受一个Map\<String, Object>类型的请求体（通过\@RequestBody注解），其中包含了需要获取的用户的ID信息。
  
  方法内部调用了一个名为postService的PostServiceImpl对象的getPostByUserId方法，将用户ID作为参数传递给它。
  
  该方法返回该用户发布的帖子列表。
  
  如果getPostByUserId方法返回一个非空的帖子列表，表示获取成功。
  
  在获取成功的情况下，该方法创建了一个ResultMap对象，并设置了成功的状态码和消息，并将帖子列表作为值存储在ResultMap中的postList键下。
  
  在获取失败的情况下，该方法创建了一个ResultMap对象，并设置了错误的状态码和消息。
  
  最后，该方法将创建的ResultMap对象作为响应返回。
  
  如果getPostByUserId方法抛出异常，则将异常信息封装为Exception对象并抛出。
3. CommentController
#sourcecode[```java
@RestController
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    CommentServiceImpl commentService;

    @PostMapping("/publish")
    public ResultMap publishComment(@RequestBody Map<String,Object> idMap) throws Exception {
        try{
            if(commentService.publishComment(String.valueOf(idMap.get("postId")),String.valueOf(idMap.get("userId")),String.valueOf(idMap.get("commentContent")))){
                return ResultMap.create().setSuccess().setSuccessMsg("publish success");
            }
            return ResultMap.create().setError().setErrorMsg("publish failed");
        }catch (Exception e){
            throw new Exception("publish comment error");
        }
    }

    @PostMapping("/getPostComment")
    public ResultMap getPostComment(@RequestBody Map<String,Object> idMap) throws Exception{
        try{
            List<Comment> commentList = commentService.getCommentsByPostId(String.valueOf(idMap.get("postId")));
            return ResultMap.create().setSuccess().setSuccessMsg("Success").setKeyValue("postId",String.valueOf(idMap.get("postId"))).setKeyValue("commentList",commentList);
        }catch (Exception e){
            throw new Exception("get comment error");
        }
    }
}
```]

该控制器类使用\@RequestMapping("/comment")注解将根URL路径映射为/comment，即所有该控制器处理的请求都应该以/comment开头。

以下是该控制器类中的几个请求处理方法：

- publishComment方法：
  
  使用\@PostMapping("/publish")注解将该方法映射到/comment/publish路径的POST请求。
  
  该方法接受一个Map\<String, Object>类型的请求体（通过\@RequestBody注解），其中包含了发布评论所需的帖子ID、用户ID和评论内容信息。
  
  方法内部调用了一个名为commentService的CommentServiceImpl对象的publishComment方法，将帖子ID、用户ID和评论内容作为参数传递给它。
  
  如果publishComment方法返回true，表示评论发布成功，该方法将返回一个包含成功状态和消息的ResultMap对象。
  
  如果publishComment方法返回false，表示评论发布失败，该方法将返回一个包含错误状态和消息的ResultMap对象。
  
  如果publishComment方法抛出异常，则将异常信息封装为Exception对象并抛出。

- getPostComment方法：

  使用\@PostMapping("/getPostComment")注解将该方法映射到/comment/getPostComment路径的POST请求。
  
  该方法接受一个Map\<String, Object>类型的请求体（通过\@RequestBody注解），其中包含了需要获取评论的帖子ID信息。
  
  方法内部调用了一个名为commentService的CommentServiceImpl对象的getCommentsByPostId方法，将帖子ID作为参数传递给它。
  
  getCommentsByPostId方法返回一个包含了该帖子下所有评论的Comment对象的列表。
  
  该方法创建了一个ResultMap对象，并设置了成功的状态码和消息，同时将帖子ID和评论列表存储在ResultMap中的相应键下。
  
  如果getCommentsByPostId方法抛出异常，则将异常信息封装为Exception对象并抛出。

=== 服务实现
1. AuthService
#sourcecode[```java
public interface AuthService {

    /**
     * register new user
     * @param userName
     * @param password
     * @return
     */
    public boolean register(String userName, String password);

    /**
     * check user exist
     * @param userName
     * @param password
     * @return
     */
    public User login(String userName, String password);
}
```]
#sourcecode[```java
@Service
@Slf4j
public class AuthServiceImpl implements AuthService{

    @Autowired
    UserServiceImpl userService;

    /**
     * register new user
     *
     * @param userName
     * @param password
     * @return
     */
    @Override
    public boolean register(String userName, String password) {
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();
        userQueryWrapper.eq("user_name",userName);
        // repeated userName
        if(userService.getOne(userQueryWrapper) != null){
            return false;
        }
        User user = new User();
        user.setUserId(UniqueKeyGenerator.generateUniqueKey());
        user.setUserName(userName);
        user.setPassword(password);
        user.setRegisterDate(LocalDateTime.now());
        user.setLoginDate(LocalDateTime.now());
        user.setLevel(1);
        return userService.save(user);
    }

    /**
     * check user exist
     *
     * @param userName
     * @param password
     * @return
     */
    @Override
    public User login(String userName, String password) {
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();
        userQueryWrapper.eq("user_name",userName).eq("password",password);
        User user = userService.getOne(userQueryWrapper);
        if(user !=null){
            user.setPassword(null);
            user.setLoginDate(LocalDateTime.now());
        }
        return user;
    }
}
```]
- 接口定义：

  AuthService 接口定义了两个方法：register和login。register用于注册新用户，login用于验证用户登录。
- AuthServiceImpl 类：

  AuthServiceImpl 类是 AuthService 接口的实现类。
  该类使用了\@Service注解，表示它是一个服务组件，可以被其他组件注入和使用。
  使用\@Slf4j注解，用于生成日志记录。
  - register 方法：
  
    register 方法用于注册新用户。
    
    首先，使用QueryWrapper对象构建一个查询条件，根据用户名查询用户是否已存在。
    如果存在重复的用户名，返回false，表示注册失败。
    如果用户名不存在重复，创建一个新的User对象，并设置用户的各个属性，如用户ID、用户名、密码、注册日期和登录日期等。
    调用userService的save方法将用户信息保存到数据库中，并返回保存操作的结果。
  - login 方法：
  
    login 方法用于验证用户登录。
    
    同样使用QueryWrapper对象构建查询条件，根据用户名和密码查询用户。
    如果查询到了用户，则将用户的密码字段设为null，以避免将密码返回给调用方。
    更新用户的登录日期为当前日期时间。
    返回查询到的用户对象，如果用户不存在，则返回null。
  
这是一个简单的身份验证服务实现，通过调用register方法进行用户注册，调用login方法进行用户登录验证。实现类使用了MyBatis-Plus框架提供的QueryWrapper对象进行数据库查询操作。
2. CommentService
#sourcecode[```java
public interface CommentService extends IService<Comment> {

    public boolean publishComment(String postId,String userId ,String commentContent);

    public List<Comment> getCommentsByPostId(String postId);
}
```]
#sourcecode[```java
@Service("CommentServiceImpl")
@Slf4j
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements CommentService{

    @Override
    public boolean publishComment(String postId, String userId, String commentContent) {
        Comment comment = new Comment();
        comment.setCommentId(UniqueKeyGenerator.generateUniqueKey());
        comment.setCommentContent(commentContent);
        comment.setCommentLike(0);
        comment.setCommentDate(LocalDateTime.now());
        comment.setUserId(userId);
        comment.setPostId(postId);
        return this.save(comment);
    }

    @Override
    public List<Comment> getCommentsByPostId(String postId) {
        QueryWrapper<Comment> commentQueryWrapper = new QueryWrapper<>();
        commentQueryWrapper.eq("post_id",postId);
        return this.list(commentQueryWrapper);
    }
}
```]
- 接口定义：

  CommentService 接口定义了两个方法：publishComment和getCommentsByPostId。publishComment用于发布评论，getCommentsByPostId用于根据帖子ID获取评论列表。
- CommentServiceImpl 类：

  CommentServiceImpl 类是 CommentService 接口的实现类。
  使用\@Service注解，表示它是一个服务组件，可以被其他组件注入和使用。
  类继承了ServiceImpl\<CommentMapper, Comment>，这个类是MyBatis-Plus提供的通用Service实现类，提供了基本的增删改查操作的默认实现。

  - publishComment 方法：
  
    publishComment 方法用于发布评论。
    
    首先，创建一个Comment对象，并设置评论的各个属性，如评论ID、评论内容、评论点赞数、评论日期、用户ID和帖子ID等。
    调用this.save方法将评论信息保存到数据库中，并返回保存操作的结果。
  
  - getCommentsByPostId 方法：
  
    getCommentsByPostId 方法用于根据帖子ID获取评论列表。
    
    创建一个QueryWrapper对象，根据帖子ID查询对应的评论。
    调用this.list方法执行查询操作，并返回查询到的评论列表。
  
这是一个简单的评论服务实现，通过调用publishComment方法发布评论，调用getCommentsByPostId方法获取帖子的评论列表。实现类继承了MyBatis-Plus提供的ServiceImpl类，利用其提供的默认实现来实现基本的增删改查操作。
3. PostService
#sourcecode[```java
public interface PostService extends IService<Post> {

    public Post getPostByTitle(String title);

    public List<Post> getPostByUserId(String userId);
}
```]
#sourcecode[```java
@Service("PostServiceImpl")
@Slf4j
public class PostServiceImpl extends ServiceImpl<PostMapper, Post> implements PostService{

    @Override
    public Post getPostByTitle(String title) {
        QueryWrapper<Post> postQueryWrapper = new QueryWrapper<>();
        postQueryWrapper.eq("post_title",title);
        return this.getOne(postQueryWrapper);
    }

    @Override
    public List<Post> getPostByUserId(String userId) {
        QueryWrapper<Post> postQueryWrapper = new QueryWrapper<>();
        postQueryWrapper.eq("user_id",userId);
        return this.list(postQueryWrapper);
    }
}
```]
- 接口定义：

  PostService 接口定义了两个方法：getPostByTitle和getPostByUserId。getPostByTitle用于根据标题获取帖子，getPostByUserId用于根据用户ID获取帖子列表。
- PostServiceImpl 类：

  PostServiceImpl 类是 PostService 接口的实现类。
  使用\@Service注解，表示它是一个服务组件，可以被其他组件注入和使用。
  使用\@Slf4j注解，用于生成日志记录。
  类继承了ServiceImpl\<PostMapper, Post>，这个类是MyBatis-Plus提供的通用Service实现类，提供了基本的增删改查操作的默认实现。
  - getPostByTitle 方法：
  
    getPostByTitle 方法用于根据标题获取帖子。
    
    创建一个QueryWrapper对象，根据标题查询对应的帖子。
    调用this.getOne方法执行查询操作，并返回查询到的帖子。
  
  - getPostByUserId 方法：
  
    getPostByUserId 方法用于根据用户ID获取帖子列表。
    
    创建一个QueryWrapper对象，根据用户ID查询对应的帖子。
    调用this.list方法执行查询操作，并返回查询到的帖子列表。

这是一个简单的帖子服务实现，通过调用getPostByTitle方法根据标题获取帖子，调用getPostByUserId方法根据用户ID获取帖子列表。实现类继承了MyBatis-Plus提供的ServiceImpl类，利用其提供的默认实现来实现基本的增删改查操作。
4. PublishPostService
#sourcecode[```java
public interface PublishPostService {
    public boolean publishPost(String postTitle,String PostContent,String userId);
}
```]
#sourcecode[```java
@Service
@Slf4j
public class PublishPostServiceImpl implements PublishPostService{

    @Autowired
    PostServiceImpl postService;

    @Override
    public boolean publishPost(String postTitle, String postContent,String userId) {
        Post post = new Post();
        post.setPostId(UniqueKeyGenerator.generateUniqueKey());
        post.setPostDate(LocalDateTime.now());
        post.setPostLike(0);
        post.setPostTitle(postTitle);
        post.setPostContent(postContent);
        post.setUserId(userId);
        return postService.save(post);
    }
}
```]

- 接口定义：

  PublishPostService 接口定义了一个方法：publishPost，用于发布帖子。
  
- PublishPostServiceImpl 类：

  PublishPostServiceImpl 类是 PublishPostService 接口的实现类。
  使用\@Service注解，表示它是一个服务组件，可以被其他组件注入和使用。
  使用\@Autowired注解将PostServiceImpl注入到PublishPostServiceImpl中，以便调用PostService的方法。
  - publishPost 方法：
  
    publishPost 方法用于发布帖子。
    
    首先，创建一个Post对象，并设置帖子的各个属性，如帖子ID、帖子日期、帖子点赞数、帖子标题、帖子内容和用户ID等。
    调用postService的save方法将帖子信息保存到数据库中，并返回保存操作的结果。

这是一个简单的发布帖子服务实现，通过调用publishPost方法将帖子信息保存到数据库中。实现类使用了\@Autowired注解将PostServiceImpl注入，以便调用PostService的方法。
=== 数据结构
1. User
#sourcecode[```java
@Data
@NoArgsConstructor
@TableName("user")
public class User implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId(value = "user_id")
    private String userId;

    @TableField("user_name")
    private String userName;

    @TableField("password")
    private String password;

    /**
     * user level
     * 0 represents administrator level
     * 1 represents common user level
     */
    @TableField("level")
    private int level;

    @TableField("register_date")
    private LocalDateTime registerDate;

    @TableField("login_date")
    private LocalDateTime loginDate;

}
```]
#sourcecode[```sql
create table user
(
    user_id       varchar(50) not null
        primary key,
    user_name     varchar(50) null,
    password      varchar(50) null,
    level         int         null,
    register_date date        null,
    login_date    date        null
);
```]
- user_id：这是一个字符串类型的字段，最大长度为50。它是用户表中的主键，用于唯一标识每个用户。主键是一个唯一的标识符，确保每个用户在表中都有唯一的标识。

- user_name：这是一个字符串类型的字段，最大长度为50。它表示用户的名称，可以用来存储用户的真实姓名或用户名。

- password：这是一个字符串类型的字段，最大长度为50。它用于存储用户的密码，以确保用户的数据安全。

- level：这是一个整数类型的字段，用于表示用户的级别。级别字段可以用来区分不同类型的用户，例如管理员和普通用户。在这个数据结构中，级别为0表示管理员级别，级别为1表示普通用户级别。

- register_date：这是一个日期类型的字段，用于存储用户的注册日期。它记录了用户注册到系统的日期和时间。

- login_date：这是一个日期类型的字段，用于存储用户的登录日期。每当用户登录到系统时，该字段将记录登录的日期和时间。

通过这些字段，"User"数据结构可以存储用户的基本信息，如用户ID、用户名、密码、用户级别以及注册和登录日期。这个数据结构可以用于在数据库中创建一个名为"user"的表格，并提供方便的操作方法来插入、更新、删除和查询用户数据。
2. Post
#sourcecode[```java
@Data
@NoArgsConstructor
@TableName("post")
public class Post implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId("post_id")
    private String postId;

    @TableField("post_title")
    private String postTitle;

    @TableField("post_content")
    private String postContent;

    @TableField("post_date")
    private LocalDateTime postDate;

    @TableField("post_like")
    private int postLike;

    @TableField("user_id")
    private String userId;
}
```]
#sourcecode[```sql
create table post
(
    post_id      varchar(50)  not null
        primary key,
    post_title   varchar(255) null,
    post_content text         null,
    post_date    date         null,
    post_like    int          null,
    user_id      varchar(50)  not null
);
```]
- post_id：这是一个字符串类型的字段，最大长度为50。它是帖子表中的主键，用于唯一标识每篇帖子。主键是一个唯一的标识符，确保每篇帖子在表中都有唯一的标识。

- post_title：这是一个字符串类型的字段，最大长度为255。它表示帖子的标题，用于描述帖子的主题或内容概要。

- post_content：这是一个文本类型的字段，用于存储帖子的详细内容。文本类型字段可以容纳较长的文本数据，适合存储帖子的正文、评论等信息。

- post_date：这是一个日期时间类型的字段，用于记录帖子的发布日期和时间。它指示了帖子何时被创建或发布。

- post_like：这是一个整数类型的字段，用于表示帖子的点赞数。它记录了帖子被点赞的次数，可以用于衡量帖子的受欢迎程度或用户对帖子的喜爱程度。

- user_id：这是一个字符串类型的字段，最大长度为50。它表示发帖用户的ID，用于关联帖子与其对应的用户。通过该字段，可以知道哪个用户发布了该篇帖子。

通过这些字段，"Post"数据结构可以存储帖子的相关信息，如帖子ID、标题、内容、发布日期、点赞数和发帖用户ID。这个数据结构可以用于在数据库中创建一个名为"post"的表格，并提供方便的操作方法来插入、更新、删除和查询帖子数据。

3. Comment
#sourcecode[```java
@Data
@NoArgsConstructor
@TableName("comment")
public class Comment implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId("comment_id")
    private String commentId;

    @TableField("post_id")
    private String postId;

    @TableField("comment_content")
    private String commentContent;

    @TableField("comment_date")
    private LocalDateTime commentDate;

    @TableField("comment_like")
    private int commentLike;

    @TableField("user_id")
    private String userId;
}
```]
#sourcecode[```sql
create table comment
(
    comment_id      varchar(50) not null
        primary key,
    post_id         varchar(50) null,
    comment_content text        null,
    comment_date    date        null,
    comment_like    int         null,
    user_id         varchar(50) not null
);
```]
- comment_id：这是一个字符串类型的字段，最大长度为50。它是评论表中的主键，用于唯一标识每条评论。主键是一个唯一的标识符，确保每条评论在表中都有唯一的标识。

- post_id：这是一个字符串类型的字段，最大长度为50。它表示被评论的帖子的ID。通过这个字段，可以将评论与对应的帖子关联起来，知道哪个帖子收到了哪些评论。

- comment_content：这是一个文本类型的字段，用于存储评论的内容。文本类型字段可以容纳较长的文本数据，适合存储评论的正文信息。

- comment_date：这是一个日期类型的字段，用于记录评论的发布日期。它指示了评论何时被创建或发布。

- comment_like：这是一个整数类型的字段，用于表示评论的点赞数。它记录了评论被点赞的次数，可以用于衡量评论的受欢迎程度或用户对评论的喜爱程度。

- user_id：这是一个字符串类型的字段，最大长度为50。它表示发表评论的用户的ID，用于关联评论与其对应的用户。通过该字段，可以知道哪个用户发布了该条评论。

通过这些字段，"Comment"数据结构可以存储评论的相关信息，如评论ID、所评论的帖子ID、内容、发布日期、点赞数和发表评论的用户ID。这个数据结构可以用于在数据库中创建一个名为"comment"的表格，并提供方便的操作方法来插入、更新、删除和查询评论数据。
== 前端

项目使用vue作为项目的前端框架，nginx作为服务转发服务器。

=== 系统结构

首先给出项目前端的项目结构：
#sourcecode(```
卷 software 的文件夹 PATH 列表
卷序列号为 92E1-68FE
D:.
│  .eslintrc.json
│  index.html
│  package-lock.json
│  package.json
│  postcss.config.js
│  README.md
│  tailwind.config.js
│  vite.config.js
│
├─.vite
│ 
│
├─public
│  │  favicon.ico
│  │  index.html
│  │
│  └─resources
│          logo.webp
│
└─src
    │  App.vue
    │  main.js
    │
    ├─assets
    │  │  homepage.svg
    │  │  logo.svg
    │  │
    │  └─css
    │          Background.module.css
    │          tailwind.css
    │
    ├─components
    │      Footer.vue
    │      FullPoster.vue
    │      HomePage.vue
    │      LoginPage.vue
    │      Navbar.vue
    │      PreviewPoster.vue
    │      Sidebar.vue
    │
    ├─pages
    │      Home.vue
    │      LoginPage.vue
    │      Post.vue
    │      PostPage.vue
    │      ReleasePost.vue
    │      test.vue
    │
    ├─router
    │      index.js
    │
    ├─store
    │      index.js
    │
    └─utils
            axios.js
            event.js
            post.js
            request.js
            接口.md
```
)项目结构


src中pages下是页面模块，utils是http请求和其他处理函数，router下是页面的逻辑和跳转，store下是状态逻辑，comonents下是侧边栏和底部栏之类不需要跟着主页面切换切换的bar，asserts里存储logo，css之类静态文件。

前端的依赖使用npm包管理器进行管理，在根目录下使用npm install来读取package.json并下载依赖
以下是项目使用的主要依赖和对应功能：

*运行时依赖项*
1. v-md-editor (^2.3.17)    
一个支持 Vue 3 的 Markdown 编辑器
2. axios (^1.5.1)           
用于进行 HTTP 请求的 Promise based 的库
3. chart.js (^4.4.0)        
一个强大且灵活的图表库
4. element-plus (^2.4.1)    
基于 Element UI 的 Vue 3 组件库
5. vue (^3.3.4)
Vue.js 框架的核心库
6. vue-router (^4.2.5)
Vue.js 应用的官方路由管理器
7. vuex (^4.1.0)
Vue.js 应用的状态管理库


*开发时依赖项*


1. vitejs/plugin-vue (^4.3.4)
Vite 构建工具对 Vue 单文件组件的支持插件
2. autoprefixer (^10.4.16)
PostCSS 插件，用于自动添加 CSS 前缀以确保跨浏览器兼容性
3. postcss (^8.4.30)
用于处理 CSS 的工具，通常与 Autoprefixer 一起使用
4. tailwindcss (^3.3.3)
一个实用的 CSS 框架，用于快速构建现代化的用户界面
5. vite (^4.4.9)
下一代前端构建工具，用于快速开发现代化的 Web 应用
=== 部署方式
1. 启动前端服务器：拉取仓库的master分支以后运行以下命令
#sourcecode(```bash
    cd frontend
    npm install
    npm run dev
```)
2. 启动nginx转发服务：配置并且运行nginx服务器，进入nginx的conf文件并修改具体内容如下：
#sourcecode(```bash
    listen 80;
    server_name localhost;

    location / {
        # 配置前端地址
        proxy_pass http://localhost:5173;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;

        # 解决跨域问题
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        add_header 'Access-Control-Allow-Headers' 'DNT,Web-MSSignature,accept,origin,content-type';

        if ($request_method = 'OPTIONS') {
            return 204;
        }
    }

    location /api/ {
        # 配置后端地址
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;

        # 解决跨域问题
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        add_header 'Access-Control-Allow-Headers' 'DNT,Web-MSSignature,accept,origin,content-type';

        if ($request_method = 'OPTIONS') {
            return 204;
        }
    }

    # 可以添加其他配置，如日志等

    # 如果需要HTTPS，可以添加SSL配置
    # ssl_certificate /path/to/your/certificate.crt;
    # ssl_certificate_key /path/to/your/private/key.key;
    # ssl_protocols TLSv1.2 TLSv1.3;
    # ssl_ciphers 'TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384';
    # ssl_prefer_server_ciphers off;
      }
```)
完成上面2步以后刷新浏览器，如果出现以下画面说明配置成功，如果没有内容产生，f12打开控制台，如果出现cros报错说明nginx配置存在问题，请仔细检查。
#img(
  image("./assets/trueRes.png"),
  caption:"正确显示"
)
#img(
  image("./assets/wrongRes.png"),
  caption:"错误显示"
)
如果没有正确显示，如上f12打开浏览器控制台显示CROS，说明不显示的原因是nginx配置错误。


#pagebreak()
= 实现与测试
== 前后端通信

项目使用axios来实现服务器和客户端之间的通信。Axios 是一个基于 Promise 的 HTTP 客户端，用于浏览器和 Node.js 环境。它是一个流行的第三方库，提供了简单而强大的用于进行 HTTP 请求的接口。Axios 支持异步操作，能够处理请求和响应的转换，还提供了拦截器（interceptors）等功能，使得在处理 HTTP 请求时更加方便和灵活。

=== 后端API测试
下表是所有可访问的API。

#tablem[
  | *接口名称* | *请求方法* | *请求路径*|
  | ------ | ---------- | ---------- | 
  | 注册              |  post |/auth/register|
  | 登录          | post  |/auth/login|
  | 发表帖子      |  post   |/post/publish|
  | 获取贴子      |  post  |/post/get|
  | 搜索帖子      |   post  |/post/search|
  | 获取主页帖子列表  |  get  |/post/getPostList|
  | 获取用户帖子列表  | post   |/post/getMyPost|
  | 发表评论| post |/comment/publish|
  | 获取帖子评论| post |/comment/getPostComment|
]

接下来使用postman对API进行测试。Postman是一款流行的API（应用程序编程接口）开发工具，用于测试、调试和发布Web服务。它提供了一个用户友好的界面，使开发人员能够轻松地创建、调试和测试API请求，同时支持自动化测试和生成文档。下列是每个API的详细请求数据和返回数据以及请求的测试结果,通过结果可知，正确的请求能够获取正确的返回结果。
1. #img(
  image("./assets/rigister.png"),
  caption:"注册"
)
2. #img(
  image("./assets/login.png"),
  caption:"登录"
)
3. #img(
  image("./assets/publishPost.png"),
  caption:"发表帖子"
)
4. #img(
  image("./assets/publishPost.png"),
  caption:"获取帖子"
)
5. #img(
  image("./assets/publishPost.png"),
  caption:"搜索帖子"
)
6. #img(
  image("./assets/getPostList.png"),
  caption:"获取主页帖子列表"
)
7. #img(
  image("./assets/getMyPost.png"),
  caption:"获取用户帖子列表"
)
8. #img(
  image("./assets/publishComment.png"),
  caption:"发表评论"
)
9. #img(
  image("./assets/getPostComment.png"),
  caption:"获取帖子评论"
)
=== 前端API测试

前端使用axios库构建http请求，在dev环境下构建测试页面http://localhost:5173/post/test测试请求的正确性。项目/frontend/src/utils文件夹下存储了所需的http请求，包括post,request等。
以下是前端API代码
#sourcecode(```JS
import axios from 'axios';

function myAxios(axiosConfig) {
  const service = axios.create({
    baseURL: 'http://localhost:8080', // 设置统一的请求前缀
    timeout: 10000, // 设置统一的超时时长
  });

  return service(axiosConfig)
}

export default myAxios;

```
)基本axios对象构建，其他axios都将会继承该方法。
#sourcecode(```JS
import axios from "axios";

const postPublishUrl = "http://localhost:8080/post/publish";
const commentPublishUrl = "http://localhost:8080/comment/publish";

const headers = {
  "Content-Type": "application/json",
};

export function postPublishAPI(postTitle, postContent, userId) {
  return axios.post(
    postPublishUrl,
    {
      postTitle: postTitle,
      postContent: postContent,
      userId: userId,
    },
    { headers }
  );
}

export function commentPublishAPI(postId, userId, commentContent) {
  return axios.post(
    commentPublishUrl,
    {
      postId: postId,
      userId: userId,
      commentContent: commentContent,
    },
    { headers }
  );
}

export function rigisterAPI(postTitle, postContent, userId) {
  return axios.post(
    postPublishUrl,
    {
      postTitle: postTitle,
      postContent: postContent,
      userId: userId,
    },
    { headers }
  );
}
export function loginAPI(postTitle, postContent, userId) {
  return axios.post(
    postPublishUrl,
    {
      postTitle: postTitle,
      postContent: postContent,
      userId: userId,
    },
    { headers }
  );
}
export function publishPostAPI(postId, userId, commentContent) {
  return axios.post(
    commentPublishUrl,
    {
      postId: postId,
      userId: userId,
      commentContent: commentContent,
    },
    { headers }
  );
}
export function searchPostAPI(postId, userId, commentContent) {
  return axios.post(
    commentPublishUrl,
    {
      postId: postId,
      userId: userId,
      commentContent: commentContent,
    },
    { headers }
  );
}

export default { postPublishAPI, commentPublishAPI };


```)
#sourcecode(```JS
import axios from "axios";
const getPostByIdAPIUrl = "http://127.0.0.1:8080/post/get";
const getPostListAPIUrl = "http://localhost:8080/post/getPostList";
const getPostCommentListAPIUrl =
  "http://localhost:8080/comment/getPostComment";
const headers = {
  "Content-Type": "application/json",
};

export function getPostByIdAPI(postId) {
  return axios.post(
    getPostByIdAPIUrl,
    {
      postId: postId,
    },
    { headers }
  );
}

export function getPostListAPI() {
  return axios.get(getPostListAPIUrl, { headers });
}

export function getPostCommentListAPI(postId) {
  return axios.post(
    getPostCommentListAPIUrl,
    {
      postId: postId,
    },
    { headers }
  );
}
export default {
  getPostByIdAPI,
  getPostListAPI,
  getPostCommentListAPI,
};


```)以上代码就是前端API请求的全部JS代码

值得注意的是，因为axios是异步请求，它的返回值是一个promise对象。

promise对象意味着它可以在未来的某个时间点完成，切换状态（仅此一次）并且返回操作的结果（promise一共有三种状态，pedding进行中，fulfilled已完成，rejected已失败）。

因为promise对象一定会在获取结果以后状态发生改变，因此可以在状态发生改变时调用函数读取状态并进行相应处理来实现http请求中回调函数的功能（因为发出请求需要等待一段时间才能获得返回值）。

综上在项目里使用上述API的http请求的操作是值得注意的。以getPostByIdAPI为例展示使用方法如下。
#sourcecode(```JS
        getPostByIdAPI(0).then(response => {
            //let res = response.data;
            //console.log('title:', response.data.post.postTitle);
            //console.log('content:', response.data.post.postContent);
            this.postData = response.data.post;
            //let postData = response.data.post;
            //console.log('响应数据：', postData);
        })
        .catch(error => {
            console.error('请求失败：', error);
        });
        getPostListAPI().then(response => {
            //console.log('响应数据：', response.data);
            console.log('第一个的title:', response.data.postList[0].postTitle);
            this.postList = response.data.postList;
        })
```)
通过代码可知处理http请求时使用then()函数获取异步返回使用catch()函数捕获异常返回，其他API请求类似。


== 前端路由
== 前端页面显示

页面主要分为三部分，主页，帖子详情页和登录页，Vue 会自动跟踪 JavaScript 状态并在其发生变化时响应式地更新 DOM。因此数据和页面显示是双向绑定的,如果用户更新了View，Model的数据也自动被更新了。以下是页面的显示效果。

#img(
  image("assets/PostList.png"),
  caption:"主页"
)
#img(
  image("assets/postPage.png"),
  caption:"帖子详情页"
)
#img(
  image("assets/commentChartPage.png"),
  caption:"登录页"
)

#img(
  image("assets/loginPage.png"),
  caption:"发表评论的表单"
)

== 结果分析

通过前后端一系列工作实现了诸如浏览帖子，浏览具体帖子每层楼评论，登录，注册，搜索帖子等具体功能，基本实现了一个树洞的要求。
#pagebreak()

= 总结

== 用户反馈

因为不存在真实的用户，因此采取小组内互评的方式。总的来说，我们的树洞项目还存在许多不足，但是也有很多值得称道的地方。

前端的页面不完善，还存在很多没有完成的工作，比如状态转移系统和搜索系统，页面仍较为简陋。但是前端采用了可拓展性很高的先进的架构。VUE的双向绑定使得dom可以动态的更新，nginx采用反向转发的方式，保证了安全性的同时解决了浏览器的跨域问题，而且具有很高的扩展性。

后端实现了相当完整的系统，实现了诸多的业务逻辑，但也存在许多的瑕疵，例如：没有对数据库中数据进行完整性约束，导致数据存在不统一的可能（修改某张表主键但是另一张表的外键没有做对应的修改）。

== 全文总结

在本次课程设计任务中，我们通过合理分工，按照软件设计的基本流程和规范设计了基于前后端分离的论坛Web App，基本达成了课程设计所提出的要求。

本次工作主要分为需求分析、概要设计、开发与测试等一系列流程。

=== 需求分析

在需求分析阶段，我们首先构建并用文字描述NABCD模型；接着，我们绘制了UML需求分析图和数据流图，明确了要设计的需求和可能的数据存储模型；最后，我们设计了原型系统。

=== 概要设计

在概要设计阶段，我们分别从环境搭建、工程配置、系统结构、接口声明、服务实现等多个方面阐述了我们的系统设计。

=== 开发与测试

在开发阶段，我们先并行地开发前后端，等基本开发完成后，再整合前后端并对前后端功能分别测试。在测试阶段，我们使用了PostMan等请求测试工具，分别对于前后端通信、前端路由、前端界面显示、后端数据库测试等进行了测试。

#pagebreak()

= 体会
// #indent() //由于华科使用自创引用格式，基本上为 GB/T 7714 去掉[J]、[C]、[M] 等。所以需要用 show rule 来自定义格式，原理为读取自定义的 bibitems.
// //yaml 文件再一项项渲染出来，因此要求自己维护顺序，使用时请取消 \#references() 前的注释。

张钧玮：我负责前后端的交互设计开发，确保前端的请求能够得到后端的正确响应，并且数据能够顺畅地流动。我通过这个过程掌握了API的设计和优化，运用了自己对于网络请求和异步编程的深入理解，确保了用户界面的交互和后端服务的稳定性。

马耀辉：我负责后端设计和开发任务，是项目中极其关键的一个部分，包括了数据库设计、服务器逻辑处理以及确保数据安全性和稳定性。通过这次项目，我深入实践了Spring Boot框架，确保了我们的论坛能够处理大量并发请求，同时维护了系统的高性能和安全性。

夏彦文：我承担了前端网页设计和开发的职责。这个角色让我深入了解了前端框架，特别是Vue.js。在这之前，我已经熟悉了使用HTML和CSS来搭建基础网页，并且有过TypeScript + React的编程经验。通过这次项目，我首次系统地学习并实践了Vue.js，在构建动态和响应式的用户界面方面取得了实质性的进展。





总而言之，我们通过这个项目深刻理解了软件开发的多面性和团队协作的重要性。
#pagebreak()

= 附录

附录源代码见 ../carrot-hole