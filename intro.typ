#import "components/mainmatter.typ": alink, mark-no-header
#import "components/chapter-intro.typ": chapter-intro

#pagebreak()
#mark-no-header()


#align(center+horizon)[
    #line(
        length: 80%,
        stroke: 2pt + rgb("#888888")
    )

    #v(10pt)

    #text(size: 1.5em)[
        This book is crafted by people, not AI. \
        \
        Illustrations are original work \
        by Arialdo and Nanou.
    ]

    #v(10pt)

    #line(
        length: 80%,
        stroke: 2pt + rgb("#888888")
    )
]


#pagebreak()
#mark-no-header()



#let link_send_pr = alink(
    "https://github.com/arialdomartini/arialdomartini.github.io/",
    [send me a pull request], []
)

#v(1fr)
#text(size: 1em)[
    I am not a native English speaker: if you spot any typo or weird
    sentence, feel free to #link_send_pr.

    #v(10pt)

    Edited with ❤️ with Typst and Emacs.

    #v(10pt)

]