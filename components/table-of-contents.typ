#let table-of-contents() = [

    // Emphasize Chapters in TOC:
    #show outline.entry: it => {
        let entry = it.indented(it.prefix(), it.inner(), gap: .5em)

        if it.level == 1 {
            v(1em, weak: true)
            text(size: 1.2em)[
                #smallcaps(strong(entry))
            ]
        }
        else {entry}
    }

    #outline(title: "Table of Contents")
]
