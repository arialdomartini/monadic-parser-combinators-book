#let division-line() = {
    align(center)[
        #line(
            length: 80%,
            stroke: 3pt + rgb("#000000")
        )]}

#let chapter-intro(content, logo, width) = {

    division-line()
    v(0em)
    
    place(
        top + left,
        dx: -40pt,
        dy: 125pt,
        image(logo, width: width)
    )
        
    text(1.5em)[
        #grid(gutter: .8em, columns: (1fr),
            align(right, content.at(0)), // first part, right aligned (wrapping around the logo)
            content.at(1)                // second part, justified
        )]
    
    division-line()

    h(1.5em)
    set text(1em, rgb("#555555"))
    set par(leading: 1.4em)
    
    pagebreak()
}