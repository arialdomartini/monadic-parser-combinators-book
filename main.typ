
///////
// Page
///////

#set page(paper: "a5")

#set par(
    justify: true
)


#show link: it => {
    underline(it)
    footnote([#it.body --- #it.dest])
}

////////
// Codly
////////


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



////////////////////
// Table of Contents
////////////////////


// Emphasize Chapters in TOC:
#show outline.entry: it => {
    let entry = it.indented(it.prefix(), it.inner(), gap: 0em)

    if it.level == 1 {
        v(1em, weak: true)
        text(size: 1.2em)[
            #smallcaps(strong(entry))
        ]
    }
    else {entry}
}


#outline(title: "Table of Content")



///////////
// Headings
///////////

#set heading(numbering: "1.1.1")

#show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
}
 

// Heading numbers on the left margin
#show heading: it => {
    let headingNumber = counter(heading)
    rect(
        stroke: {},
        inset: 0em,

            place(
                right,
                dx: -100% - 0.618em,
                text(
                    headingNumber.display()
                ),
            ) + it.body

    )
}


#show heading.where(level: 1): it => {
    pagebreak(weak: true)
 
    let numbers = counter(heading).at(it.location())
    let formatted-number = numbering(it.numbering, ..numbers)

    align(center, [
        #text(size: 8em,
            formatted-number) \
    
        #smallcaps(text(
            size: 1.5em,
            weight: "bold",
            it.body))])
    v(2em)

}


#include "content.typ"
