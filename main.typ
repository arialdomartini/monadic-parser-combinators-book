#show link: it => {
    underline(it)
    footnote([#it.body --- #it.dest])
}

#show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
}

#set heading(numbering: "1.")

#set page(paper: "a5")


#import "@preview/codly:1.3.0": *

#show: codly-init.with()
#codly(
    radius: 0em,
    fill: luma(255),
    zebra-fill: luma(255),
    stroke: 1pt + luma(255),
    smart-indent: false,
    display-icon: false,
    display-name: false,
    breakable: true,
    number-format: none
)


#include "content.typ"
