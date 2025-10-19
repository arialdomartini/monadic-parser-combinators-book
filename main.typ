#show link: it => {
    underline(it)
    footnote([#it.body --- #it.dest])
}


///////////
// Headings
///////////

#set heading(numbering: "1.")

#show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
}


// Emphasize Chapters in TOC:
#show outline.entry: it => {
    let entry = it.indented(it.prefix(), it.inner(), gap: 0em)

    if it.level == 1 {
        v(1em, weak: true)
        strong(entry)
    }
    else {entry}
}
 
// Heading numbers on the left margin
#show heading: it => {
  rect(
    stroke: {},
    inset: 0em,
    place(
      right,
      dx: -100% - 0.618em,
      text(
        counter(heading).display()
      ),
    ) + it.body
  )
}  


////////////////////
// Table of Contents
////////////////////


// Emphasize Chapters in TOC:
#show outline.entry: it => {
    let entry = it.indented(it.prefix(), it.inner(), gap: 0em)

    if it.level == 1 {
        v(1em, weak: true)
        strong(entry)
    }
    else {entry}
}



 ///////
 // Page
 ///////
 

///////
// Page
///////

#set page(paper: "a5")

#set par(
    justify: true
)

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
