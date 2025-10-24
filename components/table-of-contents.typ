#let table-of-contents() = [

    #show outline.entry: it => {
        let entry = it.indented(it.prefix(), it.inner(), gap: .5em)

        let content ={
            if it.level == 1 {
                v(1em, weak: true)
                text(size: 1.2em)[
                    #smallcaps(strong(entry))
                ]
            }
            else {
                entry
            }
        }

        link(it.element.location(), content)
    }

    
    #outline(title: "Table of Contents")
]
