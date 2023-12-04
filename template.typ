#let heiti = ("Times New Roman", "Heiti SC", "Heiti TC", "SimHei")
#let songti = ("Times New Roman", "Songti SC", "Songti TC", "SimSun")
#let zhongsong = ("Times New Roman","STZhongsong", "SimSun")

#let bib_cite(..name) = {
  super(cite(..name))
}

#let indent() = {
  box(width: 2em)
}

#let indent_par(body) = {
  box(width: 1.8em)
  body
}

#let equation_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("equation-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    "(" + str(chapt) + "-" + str(n + 1) + ")"
  })
}

#let table_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("table-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    str(chapt) + "-" + str(n + 1)
  })
}

#let image_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("image-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    str(chapt) + "-" + str(n + 1)
  })
}


#let equation(equation, caption: "") = {
  figure(
    equation,
    caption: caption,
    supplement: [公式],
    numbering: equation_num,
    kind: "equation",
  )
}

#let tbl(tbl, caption: "") = {
  figure(
    tbl,
    caption: caption,
    supplement: [表],
    numbering: table_num,
    kind: "table",
  )
}

#let img(img, caption: "") = {
  figure(
    img,
    caption: caption,
    supplement: [图],
    // numbering: image_num,
    // kind: "image",
  )
}


#let empty_par() = {
  v(-1em)
  box()
}

// inspired from https://github.com/lucifer1004/pkuthss-typst.git
#let chinese_outline() = {
  align(center)[
    #text(font: heiti, size: 18pt, "目　　录")
  ]

  set text(font: songti, size: 12pt)
  // 临时取消目录的首行缩进
  set par(leading: 1.24em, first-line-indent: 0pt)
  locate(loc => {
    let elements = query(heading.where(outlined: true), loc)
    for el in elements {
      // 是否有 el 位于前面，前面的目录中用拉丁数字，后面的用阿拉伯数字
      let before_toc = query(heading.where(outlined: true).before(loc), loc).find((one) => {one.body == el.body}) != none
      let page_num = if before_toc {
        numbering("I", counter(page).at(el.location()).first())
      } else {
        counter(page).at(el.location()).first()
      }

      link(el.location())[#{
        // acknoledgement has no numbering
        let chapt_num = if el.numbering != none {
          numbering(el.numbering, ..counter(heading).at(el.location()))
        } else {none}

        if el.level == 1 {
          set text(weight: "black")
          if chapt_num == none {} else {
            chapt_num
            "　　"
          }
          el.body
        } else {
          chapt_num
          "　"
          el.body
        }
      }]

      // 填充 ......
      box(width: 1fr, h(0.5em) + box(width: 1fr, repeat[.]) + h(0.5em))
      [#page_num]
      linebreak()
    }
  })
}

#let project(
  anony: false, // 是否匿名化处理
  title: "",
  abstract_zh: [],
  abstract_en: [],
  keywords_zh: (),
  keywords_en: (),
  school: "",
  author: "",
  id: "",
  mentor: "",
  class: "",
  date: (1926, 8, 17),
  body,
) = {
  // 引用的时候，图表公式等的 numbering 会有错误，所以用引用 element 手动查
  show ref: it => {
    if it.element != none and it.element.func() == figure {
      let el = it.element
      let loc = el.location()
      let chapt = counter(heading).at(loc).at(0)

      // 自动跳转
      link(loc)[#if el.kind == "image" or el.kind == "table" {
          // 每章有独立的计数器
          let num = counter(el.kind + "-chapter" + str(chapt)).at(loc).at(0) + 1
          it.element.supplement
          " "
          str(chapt)
          "-"
          str(num)
        } else if el.kind == "equation" {
          // 公式有 '(' ')'
          let num = counter(el.kind + "-chapter" + str(chapt)).at(loc).at(0) + 1
          it.element.supplement
          " ("
          str(chapt)
          "-"
          str(num)
          ")"
        } else {
          it
        }
      ]
    } else {
      it
    }
  }

  // 图表公式的排版
  show figure: it => {
    set align(center)
    if it.kind == "image" {
      set text(font: heiti, size: 12pt)
      it.body
      it.supplement
      " " + it.counter.display(it.numbering)
      "　" + it.caption
      locate(loc => {
        let chapt = counter(heading).at(loc).at(0)
        let c = counter("image-chapter" + str(chapt))
        c.step()
      })
    } else if it.kind == "table" {
      set text(font: heiti, size: 12pt)
      it.supplement
      " " + it.counter.display(it.numbering)
      "　" + it.caption
      set text(font: songti, size: 10.5pt)
      it.body
      locate(loc => {
        let chapt = counter(heading).at(loc).at(0)
        let c = counter("table-chapter" + str(chapt))
        c.step()
      })
    } else if it.kind == "equation" {
      // 通过大比例来达到中间和靠右的排布
      grid(
        columns: (20fr, 1fr),
        it.body,
        align(center + horizon,
          it.counter.display(it.numbering)
        )
      )
      locate(loc => {
        let chapt = counter(heading).at(loc).at(0)
        let c = counter("equation-chapter" + str(chapt))
        c.step()
      })
    } else {
      it
    }
  }
  set page(paper: "a4", margin: (
    top: 2.5cm,
    bottom: 2.5cm,
    left: 3cm,
    right: 3cm
  ))

  // 封面
  align(center)[
    // hust logo
    #v(30pt)

    // 匿名化处理需要去掉个人、机构信息
    #let logo_path = if not anony {
      "./assets/hust.png"
    } else {
      "./assets/black.png"
    }
    #image(logo_path, width: 55%, height: 7%)

    #v(20pt)

    #text(
      size: 36pt,
      font: zhongsong,
      weight: "bold"
    )[大数据管理\ 课程报告]

    #v(10pt)

    #text(
      font: heiti,
      size: 22pt,
    )[
      #title
    ]

    #v(10pt)

    #let info_value(body) = {
      rect(
        width: 100%,
        inset: 2pt,
        stroke: (
          bottom: 1pt + black
        ),
        text(
          font: zhongsong,
          size: 16pt,
          bottom-edge: "descender"
        )[
          #body
        ]
      )
    }

    #let info_key(body) = {
      rect(width: 100%, inset: 2pt,
       stroke: none,
       text(
        font: zhongsong,
        size: 16pt,
        body
      ))
    }

    #grid(
      columns: (70pt, 180pt),
      rows: (40pt, 40pt),
      gutter: 3pt,
      info_key("院　　系"),
      info_value(if not anony { school } else { "██████████" }),
      info_key("专业班级"),
      info_value(if not anony { class } else { "██████████" }),
      info_key("姓　　名"),
      info_value(if not anony { author } else { "██████████" }),
      info_key("学　　号"),
      info_value(if not anony { id } else { "██████████" }),
      info_key("指导教师"),
      info_value(if not anony { mentor } else { "██████████" }),
    )

    #v(20pt)
    #align(right)[
      #table(
        align: center,

        [分数]," ",
        [教师签名]," ",
      )
    ]
    #v(20pt)
    #text(
      font: zhongsong,
      size: 16pt,
    )[
      #date.at(0) 年 #date.at(1) 月 #date.at(2) 日
    ]
    #pagebreak()
  ]


  counter(page).update(0)
  // 页眉
  set page(
    header: {
      set text(font: songti, 10pt, baseline: 8pt, spacing: 3pt)
      set align(center)
      if not anony {
        [大数据管理课程报告]
      } else {
        [█████████████████████████]
      }

      line(length: 100%, stroke: 0.7pt)
    }
  )

  // 页脚
  // 封面不算页数
  set page(
    footer: {
      set align(center)

      grid(
        columns: (5fr, 1fr, 5fr),
        line(length: 100%, stroke: 0.7pt),
        text(font: songti, 10pt, baseline: -3pt,
          counter(page).display("I")
        ),
        line(length: 100%, stroke: 0.7pt)
      )
    }
  )

  set text(font: songti, 12pt)
  set par(justify: true, leading: 1.24em, first-line-indent: 2em)
  show par: set block(spacing: 1.24em)

  set heading(numbering: (..nums) => {
    nums.pos().map(str).join(".") + "　"
  })
  show heading.where(level: 1): it => {
    set align(center)
    set text(weight: "bold", font: heiti, size: 18pt)
    set block(spacing: 1.5em)
    it
  }
  show heading.where(level: 2): it => {
    set text(weight: "bold", font: heiti, size: 14pt)
    set block(above: 1.5em, below: 1.5em)
    it
  }

  // 首段不缩进，手动加上 box
  show heading: it => {
    set text(weight: "bold", font: heiti, size: 12pt)
    set block(above: 1.5em, below: 1.5em)
    it
  } + empty_par()

  counter(page).update(1)

  // 目录
  chinese_outline()

  // 正文的页脚

  set page(
    footer: {
      set align(center)

      grid(
        columns: (5fr, 1fr, 5fr),
        line(length: 100%, stroke: 0.7pt),
        text(font: songti, 10pt, baseline: -3pt,
          counter(page).display("1")
        ),
        line(length: 100%, stroke: 0.7pt)
      )
    }
  )


  counter(page).update(1)

  // 代码块(TODO: 加入行数)
  show raw: it => {
    set text(font: songti, 12pt)
    set block(inset: 5pt, fill: rgb(217, 217, 217, 1), width: 100%)
    it
  }

  body
}

// 三线表
#let tlt_header(content) = {
  set align(center)
  rect(
    width: 100%,
    stroke: (bottom: 1pt),
    [#content],
  )
}

#let tlt_cell(content) = {
  set align(center)
  rect(
    width: 100%,
    stroke: none,
    [#content]
  )
}

#let tlt_row(r) = {
  (..r.map(tlt_cell).flatten())
}

#let three_line_table(values) = {
  rect(
    stroke: (bottom: 1pt, top: 1pt),
    inset: 0pt,
    outset: 0pt,
    grid(
      columns: (auto),
      rows: (auto),
      // table title
      grid(
        columns: values.at(0).len(),
        ..values.at(0).map(tlt_header).flatten()
      ),

      grid(
        columns: values.at(0).len(),
        ..values.slice(1).map(tlt_row).flatten()
      ),
    )
  )
}

