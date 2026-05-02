#let alink(to, text, note) = {
    link(to)[#text]

    if note == [] {
        footnote(link(to)[#to])
    }
    else {
        footnote([#link(to)[#to] --- #note])
    }
}

#let no-header-pages = state("no-header-pages", ())

#let mark-no-header() = context {
    let p = here().page()
    no-header-pages.update(pages => pages + (p,))
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


    #let is-no-header-page() = context {
        let pages = no-header-pages.final()
        pages.contains(here().page())
    }

    #set page(
        header-ascent: 0pt,
        header: context {
            let pages = no-header-pages.final()
            if not is-chapter-page() and not pages.contains(here().page()) {
                my-header
            }
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
    
    #let tablecolor = luma(200)
    #set table(
        align: center,
        stroke: (x, y) => 1pt + tablecolor,
        fill: (x, y) =>
        if y == 0 {
            rgb("#eeeeee")
        }
    )
    #show table.cell.where(y: 0): it => strong(text(black, it))
    #show table.cell: it => {
        set text(size: 1em)
        set par(justify: false)
        it
    }
    #show table: it => align(center, it)


    ///////
    // Code
    ///////
    #let codeBackground = rgb("#f5faf5")
    #let codeStrokeLine = 1pt + rgb("#ffffff")
    #let codeStroke = (
        top: codeStrokeLine,
        bottom: codeStrokeLine
    )


    #show raw: it => {
        box(
            fill: rgb("#f5f5f5"),
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
        fill: codeBackground,
        zebra-fill: codeBackground,
        stroke: 0pt + luma(255),
        smart-indent: false,
        display-icon: false,
        display-name: false,
        breakable: true,
        number-format: none
    )

    #show raw.where(block: true): set text(0.8em, font: "Monoid")

    
    #show raw.where(block: true): it => {
        pad(
            x: -2.5cm,
            block(
                width: 100% + 2 * 4cm,
                inset: (x: 2.5cm, y: 1em),
                fill: codeBackground,
                stroke: codeStroke, 
                it
            )
        )
    }


    ///////////
    // Headings
    ///////////

    #set heading(numbering: "1.1.1")


    #show heading: it => {
        let headingNumber = counter(heading)
        block(above: 2.0em, below: 0.8em)[
            #rect(
                stroke: {},
                inset: 0em,
                place(
                    right,
                    dx: -100% - 1.8em,
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
        v(1em)
    }    

    ////////////
    // Footnotes
    ////////////

    #set footnote.entry(
        gap: 0.8em,
    )    

    #body
]