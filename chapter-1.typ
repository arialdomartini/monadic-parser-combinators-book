== Introduction

<introduction>

You want to invent a new language, and you want to do this in F\#,
don't you? And, of course, you want to base its parser on Monadic
Parser Combinators. You've always wanted. So, let's make it happen!

The compiler of your beautiful new language --- with which you will
bring the use of `goto` and `null` back to life --- will have several
components:

- A Lexer, for splitting the source code into tokens.
- A Parser, to convert the token sequence into a syntax tree, and to
  check the grammatical structure.
- An Intermediate Code Generator.
- A Linker, and so on.

Here we are focusing on the very first component: a piece of code able
to analyze the source, to check its syntax against the esoteric formal
grammar you defined, and to generate something very well structured for
the next components to crunch.

It would be a (probably very complex) function with a signature like:

```fsharp
type SourceCode = string

type AbstractSyntaxTree =
    | Goto of Label
    | VariableDefinition of ...
    | ...

val parser : SourceCode -> AbstractSyntaxTree
```

If you think about it, that's not qualitatively different from
deserializing a JSON string:

```fsharp
type JSON = string

val jsonDeserializer : JSON  -> MyObject
```

Of course, it's likely that a programming language grammar is more
complex than the JSON grammar. But the two concepts are alike, and so
are the signatures.

#link("https://tree-sitter.github.io/tree-sitter/")[Tree-sitter] too
does something similar. It parses a string like:

```
"let x = 42"
```

and it emits a tree like:

```
(program
  (variable_declaration
    (lexical_declaration
      (identifier)
      (assignment_expression
        (number)))))
```

We can imagine the Tree-sitter grammar for F\# as a function with this
signature:

```fsharp
val treeSitter : SourceCode -> TreeSitterSExpression
```

I guess you see the pattern. \
A parser is a function that takes loosely-structured data (usually ---
but not necessarily --- text), and tries to build a more structured data
out of it, accordingly to the rules of a formal grammar.

== Mr.James, It's Parsers all The Way Down
<mr.james-its-parsers-all-the-way-down>
We say that the input data is loosely-structured because, in fact, it is
not granted to adhere to the rules of the chosen grammar. Indeed, if it
violates them, then we expect the parser to fail and to emit an error,
to help the user identify the syntax errors.

There are multiple approaches to parsing, including the renowned Regular
Expressions. \
Monadic Parser Combinators are a particularly fascinating one: they are
an example of
#link("https://en.wikipedia.org/wiki/Recursive_descent_parser")[Recursive Descent Parsers];.
This means that no matter how complex the parser for a grammar is, it is
defined based on smaller, simpler parsers, and those in turn are defined
based on even smaller and simpler ones, and so on recursively, down to
the trivial parsers. \
You can see the same from the opposite perspective: starting from the
trivial parsers, by #emph[combining] them together and then by combining
their results, recursively, the parser for any arbitrary grammar can be
built.

Now, if writing the trivial parsers is, well, trivial, the only
challenge that's left is to learn how to #emph[combine] parsers. That
is, how Parsers Combinators work.

That's the goal of these pages.

== How we will proceed
<how-we-will-proceed>
There are many similar series online, some specific to F\# --- such as
#link("https://fsharpforfunandprofit.com/series/understanding-parser-combinators/")[The "Understanding Parser Combinators" series]
by Scott Wlaschin --- many others based on Haskell, like the excellent
#link("https://hasura.io/blog/parser-combinators-walkthrough")[Parser Combinators: a Walkthrough, Or: Write you a Parsec for Great Good]
by Antoine Leblanc. \
This post tries to stand out in a few different ways:

- If other attempts to this topic left you scratching your head, this
  series should make things a lot easier. \
  I've done my best to keep the learning curve as smooth as possible.
  Having to pick between being brief and assuming you knew a lot, or
  taking a longer path I went with the latter. I think it's nicer to
  know why stuff works rather than being hit with jargon-heavy
  explanations.

- Many tutorials begin with writing a simple parser --- conventionally,
  the single-character parser. This does not. Instead, we will focus on
  combinators first, postponing the implementation of concrete parsers.
  When I was first introduced to parsers, I was just confused: what on
  earth does it mean to parse a single character returning a character?
  What's the point? Where is this leading me? \
  I hope I can help you skip past that initial disorientation entirely.

- Parser Combinators are the the #emph[leit-motiv] and serve as the
  central theme of this book. Nevertheless, we'll often stray from the
  main path and let our imagination roam, exploring a variety of other
  subjects along the way. You can consider these pages an invitation to
  discover Functors, Applicatives, and Monads.

- We will write code with Test-Driven Development. \
  Isn't it ironic that we developers often lament the absence of tests
  in our daily job projects and yet, when it comes to writing posts,
  tutorials and books, we never address testing at all?

Fine, enough with the introduction. Ready? Treat yourself to a sorbet,
then let's get started.

== Notes
<notes>
I am not a native English speaker: if you spot any typo or weird
sentence, feel free to
#link("https://github.com/arialdomartini/arialdomartini.github.io/")[send me a pull request];.

This book is crafted by people, not AI. Illustrations are original
work by Nanou.
