#show link: it => {
    underline(it)
    footnote([#it.body --- #it.dest])
}

#show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
}

#set heading(numbering: "1.")


#outline(title: "Table of Content")

#include "chapter-1.typ"
#include "chapter-2.typ"
#include "chapter-3.typ"
#include "chapter-4.typ"
#include "chapter-5.typ"
#include "chapter-6.typ"
#include "chapter-7.typ"
#include "chapter-8.typ"
#include "chapter-9.typ"
#include "chapter-10.typ"
#include "chapter-11.typ"
#include "chapter-12.typ"
#include "chapter-13.typ"
#include "chapter-14.typ"
#include "chapter-15.typ"
#include "chapter-16.typ"
