#import "myTemplate.typ": *
#import "@preview/codelst:2.0.0": sourcecode
#import "@preview/codly:1.0.0": *

#show:codly-init.with()

#codly(
  languages: (
    rust: (
      name: "Rust",
    ),
    csharp: (
      name: "C#",
    ),
    c: (
      name: "C#",
    ),
    cpp: (
      name: "C++",
    ),
  )
)

#show: project.with(
  anonymous: false,
  title: "生产实习",
  author: "张钧玮",
  school: "计算机学院",
  id: "U202115520",
  mentor: "熊硕",
  class: "大数据 专业 2102 班",
  date: (2024, 8, 25)
)


= 兵棋电子化

== Abstract

使用Unity&&C\#实现的 「对于东亚泛太地区在避免全面军事冲突情况下经济舆论对抗的兵棋推演」。由实体版桌游进行电子化，桌游由熊硕老师提供，demo版本数据使用mock数据。实现了数据，UI，游戏逻辑的分离，具有良好的高耦合低内聚特性。

== 游戏系统

Demo实现了兵棋所期望的由国家实体对于经济和舆论进行推演的功能。具体如下：
1. 玩家四位，包括中国大陆，中国台湾，美国，日本。
2. 回合制进行游戏，对于每个回合，每位玩家都可以选择对于经济和舆论进行「影响」。
3. 所谓「影响」，就是扮演国家实体而期望对国家的某项数值（经济OR舆论）产生积极的影响。然而，因为不存在全知全能的国家实体，因此任何影响的结果都是随机而且不可控的。具体来说Manager会随机的从指标对应的事件库中选择随机的事件进行执行，进而以选择指标为中心影响国家实体。
4. 在每个回合，每位玩家都有一次行动的机会，而玩家的行动是不分顺序的，当每个玩家都点击回合结束按钮，将会进入回合结束阶段。报纸刊登当回合由玩家影响产生的事件以及随机事件，然后结算结果。
5. 进行对于国家，积攒事件来推进日志，获取游戏标识（根据实体数值自动触发的事件），和平回合结束以后会根据每个玩家的游戏标识最终判断每位玩家达成的结局「和平统一/武统/全面热战」等。
6. 可能的热战阶段数据来自某所，应该涉密了，暂时不放出。

== 实习记录

实习全程使用git进行项目管理和分布式开发

git log如下，可见项目从7月9日开始，到8月24日结束，历时近两个月，中间每周都有至少两次的提交。
```bash
mushiki on  main via .NET v7.0.400
❯ git log --pretty=format:"%h %ad %s" --date=short
e1df186 2024-08-24 feat:update README
e550d31 2024-08-24 feat:add newspaper
1e60874 2024-08-24 feat:add log
4b07d66 2024-08-24 feat:update dataLoad
bb9db9a 2024-08-24 feat:clean Panel
f8dc527 2024-08-24 feat:add OnClickPrefeb
213c56d 2024-08-23 feat:add FooterPoolRender
72928b8 2024-08-22 feat:add MainData
15ece3c 2024-08-22 feat:add FootItem&&display
2187e70 2024-08-22 feat:rewrite footerPool&&AreasPanel
2cf3019 2024-08-22 feat:add MainScene&&edit AreasPanel layout
551a36f 2024-08-22 feat:add StartPanel&&StartManager
deee276 2024-08-22 feat(Managers):add PanelManager
9ecf31e 2024-08-22 feat(UIFramework):add Managers&&UIManager
91d705a 2024-08-21 feat(Scripts\UIFramework):add Base&&BasePanel
7211a52 2024-08-21 feat:add UIFramework&&UIType
84c9726 2024-07-24 Merge pull request #6 from sdqdzhang/frame-branch
695b021 2024-07-24 white frame
c0da147 2024-07-18 Merge pull request #5 from firefLiuYing/YynBranch
8e93a9e 2024-07-17 卡牌库查找id对应策略
957318e 2024-07-17 制作了能使用简单模板的所有发展策略
b67f237 2024-07-17 做了比较简单的一个发展策略模板
10b3c50 2024-07-14 Merge pull request #4 from firefLiuYing/YynBranch
8ce78f6 2024-07-14 Merge branch 'YynBranch' of https://github.com/firefLiuYing/mushiki into YynBranch
a59f63e 2024-07-14 把一些图片转为按钮
17e96ee 2024-07-14 Merge pull request #3 from firefLiuYing/YynBranch
9dfd2e9 2024-07-14 Merge branch 'main' into YynBranch
e09d6ac 2024-07-14 补个忘记传的场景变动
3293d81 2024-07-14 回合数显示
7017418 2024-07-14 当前玩家阵营地图高亮
382038c 2024-07-12 feat(data):add CampInitialData.json
d2568c3 2024-07-11 feat:change into utf-8
57587b2 2024-07-11 Merge pull request #2 from firefLiuYing/YynBranch
9206050 2024-07-11 把参数的float改成了int
57b8f1d 2024-07-11 参数的展示功能与当前玩家切换已实现
ad8c9b1 2024-07-11 完成了参数列表的具体化
d5fd0de 2024-07-11 补之前未保存的，写了阵营基类
2e7d405 2024-07-10 Merge pull request #1 from firefLiuYing/YynBranch
95bc2f7 2024-07-10 完成简易UI界面
af957de 2024-07-10 添加了UI界面最上面的一条
cecff4b 2024-07-10 建了自己的场景和Scripts文件夹
89ad5de 2024-07-09 feat:update draft board.drawio
7ab4e9c 2024-07-09 feat(todo):add todofile&&board
671c507 2024-07-09 feat(README):add todo
5f2a16a 2024-07-09 feat(.gitignore):add .gitignore
:
```

== 游戏页面

#img(
  image("assets/页面.png", height: 50%),
  caption: "开发页面"
)
#img(
  image("assets/影响.png", height: 50%),
  caption: "游戏页面"
)

== 思路实现

游戏使用C\#实现了如下系统
1. GamaManager，线程安全的单例模式。游戏加载时创建并且保证只有一份实例，全局可访问。保存玩家数据，事件库，UI对象的引用，游戏状态等。它是直接管理游戏唯一状态的直接实例，捅过静态构造的办法保证了线程安全。它实现了好几个简单的有限状态机(FSM)，优化了开发逻辑，简化了大脑负担，把诸如玩家状态，回合状态，UI面板状态都划分成了离散的状态，从而可以分儿地在各自的状态里面编写逻辑，实现了程序的高内聚。
2. UIDisplay类，所有UIDisplay的基类，包括了所有UIDisplay的基本操作，如显示，隐藏，更新等。其他继承自该父类的基类会使用Unity提供的可视化剪辑器将子类UIDisplay（例如Text）绑定到UI类的属性上。值得注意的是，指定UI被创建时候被初始化了对应UIPool的transform，对应UIPool则在和它绑定的面板被创建时候一起跟着创建，有固定的transform，而UIPool的子对象使用flexible进行管理。通过这种办法实现了比较优雅的GUI管理。
3. Item类，保存数据的最基本单位，在UIDisplay中会被绑定到UI类的属性上，用于显示数据。
4. LoadData类，用于加载数据，包括事件库，玩家数据等。
5. Prefeb类，实例化预制体的类，此时Unity的可视化编辑无法实现，手动编写代码实现对事件的监听和对UI属性的绑定和更新。使用Lambda函数监听事件，使用闭包传递参数。
6. PanelFrameWork类，管理Panel状态以及创造销毁Panel的类。，实现OnEnter，OnPause，OnResume，OnExit等多种方法，以实现:弹出事件以后旧的面板不再能被点击，新的面板被关闭以后旧的面板回复可以被点击。用栈来存储面板，每当点击时候获取顶部面板，使其暂停，然后创造新面板入栈，销毁面板时先销毁栈顶面板，出栈，然后使栈顶面板恢复。

== 困难&&难点

闭包参数传递问题：

在Unity中，假如是一个生命周期和场景生命周期一致的按钮，那么可以直接在Unity的可视化编辑器中添加监听事件。

但是更多是和场景生命周期不一致，需要手动调用构造函数生成销毁的游戏对象，需要手动编写代码实现对事件的监听和对UI属性的绑定和更新。这里采用订阅-发布模式。当对象被创建时候就添加监听函数监听其操作，使用Lambda函数监听事件。

又因为生成的游戏对象虽然是同一个预制体的克隆，但是后续会添加上不一样的数据来代表不同的影响类型，需要在点击时候了解按钮是按钮列表的哪一个，此时假如根据按钮的ID或者text判断效率低又臃肿，因此需要给予Lambda函数传递参数来获取订阅时是第几个按钮，因此传入循环变量i。

然而在使用闭包传递参数的时候，我遇到了如下的问题：

#img(
  image("assets/原代码.png",height:20%),
  caption: "原代码"
)
#img (
  image("assets/报错.png",height:20%),
  caption: "报错"
)

值得注意的是我在原代码中试图使用一个for循环来生产按钮，生产按钮的同时为它添加一个监听函数，当onclick触发的时候就可以调用监听函数执行操作。在匿名函数中传入了循环参数i，试图达到在点击按钮时候可以知道点击的是第几个按钮从而指向不同的操作调用对应的事件。然而在报错中我发现，无论点击哪个按钮传入的参数i实际上都是结束循环时候i的值，也就是5。因为不存在第五个按钮对象所以必定会出现数组越界。

这个问题出现的原因在于点击函数将比于渲染函数是一个异步操作，点击渲染经济数据的按钮unity引擎立刻就渲染好了五个按钮，然后玩家才会点击。而lambda是捕获并且延长变量的生命周期，也就是获取局部变量i的引用而不是像一般函数一样获取拷贝。在for循环中i只生成一次，然后被lamba函数多次捕获，因此所有按钮所传入的都是同一个i的引用，也就是最后的值5。为了解决这个问题，我需要在循环中生成一个新的变量，然后将i的值赋值给新变量，然后在lambda函数中传入新变量。这样的话每个按钮会持有一个单独的index引用，而不是共享一个引用。就可以正确的传入参数了。

== 总结

以上问题是我遇到的一个小问题，其实我还遇到了很多其他问题，包括但不限于架构问题，反复的重构解耦。这里不再一一赘述。

= 附录：项目目录结构
```bash
mushiki on  main via .NET v7.0.400
❯ tree .
卷 software 的文件夹 PATH 列表
卷序列号为 92E1-68FE
D:\WORKD\UNITY\MUSHIKI
├─Assets
│  ├─Assets
│  │  └─UI Elements
│  │      └─Extras
│  │          └─Rects
│  ├─Datas
│  ├─Prefabs
│  ├─Resources
│  │  ├─Datas
│  │  └─Strategy
│  │      └─Economy
│  ├─Scenes
│  └─Scripts
│      ├─Player
│      ├─Strategy
│      ├─System
│      ├─UI
│      └─UIFramework
│          ├─Base
│          └─Managers
├─todo
└─UML
```