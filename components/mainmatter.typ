
#let alink(text, to, note) = {
    link(to)[#text]

    footnote([#link(to)[#to] --- #note])

}



#let mainmatter(body) = [
    /////////
    // Header
    /////////


    #let current-chapter-title() = context {
        let last = query(heading.where(level: 1).before(here())).last()
        let num = counter(heading.where(level: 1)).at(last.location()).first()
        [Chapter #num --- #last.body]
    }
    
    #let my-header = pad(left: 0em, right: 0em, [
        // #set text(.8em, rgb("#888888"))
        #set text(.7em)
        #smallcaps(current-chapter-title())
        #h(1fr)
        #context strong[#counter(page).display()]
        #line(
            length: 100%,
            stroke: 1pt + rgb("#888888")
        )
        #v(2em)
    ])


    #let is-chapter-page() = {
        let chapters = query(heading.where(level: 1))
        chapters.any(c => c.location().page() == here().page())
    }


    #set page(
        header-ascent: 0pt,

        header: context if not is-chapter-page() {
            my-header
        }
    )

    //////////////////
    // Paragraph style
    //////////////////

    #set par(
        justify: true,
        leading: 0.84em
    )

    #show link: it => {
        
        underline(
            offset: 0.2em,
            stroke: stroke(
                paint: rgb("#888888"),
                thickness: 1pt,
                dash: (1pt, 1pt),

            ),)[#it]
    }

    
    
    #set list(marker: [\u{2023}])


    /////////
    // Tables
    /////////
    
    #let tablecolor = luma(30)
    #set table(
        align: center,
        stroke: (x, y) => 1pt + tablecolor,
        fill: (x, y) =>
        if y == 0 {
            tablecolor
        }
    )
    #show table.cell.where(y: 0): it => strong(text(white, it))
    #show table.cell: it => {
        set text(size: 1em)
        set par(justify: false)
        it
    }
    #show table: it => align(center, it)

    

    ///////
    // Code
    ///////

    #show raw: it => {
        box(
            fill: rgb("#f5f5f5"),
            // fill: rgb("#e6e8ea"),
            //      stroke: rgb("#d1d9e0b3"),
            outset: (y: 3pt),
            inset: (x: 2pt),
            radius: 3pt,
            it
        )
    }

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

    #show raw.where(block: true): set text(0.7em, font: "Monoid")



    ///////////
    // Headings
    ///////////

    #set heading(numbering: "1.1.1")

    #show heading.where(level: 1): it => {
        pagebreak(weak: true)
        it
    }


    #show heading: it => {
        let headingNumber = counter(heading)
        block(above: 2.0em)[
            #rect(
                stroke: {},
                inset: 0em,
                place(
                    right,
                    dx: -100% - 0.618em,
                    text(headingNumber.display())
                ) + it.body
            )
        ]
    }


    #show heading.where(level: 1): it => {
        pagebreak(weak: true)
 
        let numbers = counter(heading).at(it.location())
        let formatted-number = numbering(it.numbering, ..numbers)

        align(center, [
            #text(size: 8em,
                formatted-number) \
    
            #smallcaps(text(
                size: 1.2em,
                weight: "bold",
                it.body))])
        v(2em)

    }    


    #body
    
]
