#let cover() = {
    let title = "Monadic Parser Combinators"
    let subtitle = "A blatant excluse to talk about Functors, Applicative and Monads"
    let authors = "Arialdo Martini"

    let date =  datetime(
        year: 2025,
        month: 10,
        day: 7,
    )


    let cfg = (
        cover-txtcolor: rgb("#9b681b"),
        cover-bgcolor: yellow,
        line-space: 2em,
        cover-fonts: ("Monoid", "Monoid"),
        frame: "/static/frame.svg"
    )

    
    let authors = if type(authors) == array {authors.join(", ")} else {authors}
    
    let cover-bg = context {
        let m = page.margin
        let frame = image(
            width: 93%,
            cfg.frame
        )
          
        if type(m) != dictionary {
            m = (
                top: m,
                bottom: m,
                left: m,
                right: m
            )
        }
        
        v(m.top * 0.25)
        align(center + top, frame)
        
        align(center + bottom, rotate(180deg, frame))
        v(m.bottom * 0.25)
    }
        
    set text(
        fill: cfg.cover-txtcolor,
        hyphenate: false
    )
    set par(justify: false)

    page(
        margin: (x: 12%, y: 12%),
        fill: cfg.cover-bgcolor,
        background: cover-bg,
    )[
        #align(center + horizon)[
            #set par(leading: 2em)
            #context text(
                size: page.width * 0.06,
                font: cfg.cover-fonts.at(0),
                title
            )
            #linebreak()
            #set par(leading: cfg.line-space)
            #if subtitle != none {
                v(1cm)
                smallcaps(context text(
                    size: page.width * 0.03,
                    font: cfg.cover-fonts.at(1),
                    subtitle
                ))
                //v(4cm)
            }
        ]
        #align(center + bottom)[
            #block(width: 52%)[
                #context text(
                    size: page.width * 0.035,
                    font: cfg.cover-fonts.at(1),
                    authors + "\n" +
                    date.display("[year]")
                )
            ]
        ]
    ]
}

