= A Tale Of 2 Coupling Types <chapter-5>

#import "components/mainmatter.typ": alink


The `parsePerson` function delegates the parsing of GUIDs, strings and
dates to external functions. We think that this decouples it from of the
parsing logic of the specific fields. While this is indeed the case, the
code we just obtained clearly shows that some problems remain. By now,
you should have guessed why; there are in fact 2 types of coupling:

- A function can be coupled with #emph[the logic] of other components. \
  This cannot be our case: `parsePerson` does not even know how GUIDs
  are represented; this logic is completely delegated to `parseGuid`.

- A function could be coupled with #emph[the mechanics] of glueing
  things together, what we called the #emph[effectful logic];. \
  This means that even if it is #emph[functionally isolated];, the code
  is #emph[structurally] influenced by the #emph[glueing mechanism];.
  This must be our case.

Now, if you more into OOP than into functional programming, it is likely
that you never heard of the second form of coupling. After all, in OOP
"#emph[glueing things together];" is rarely a big deal. In OOP there are
a few techniques for gluing things together --- such as sending messages
to objects in a sequence, or passing values around or applying values to
functions --- and all of them are natively implemented by the
programming language. And all boil down to the notion of #emph[function
application];.

== Dumb and Smart Function Applications
<dumb-and-smart-function-applications>
The native function application works just fine as long as it operates
within the simple case of things with compatible signatures:

```ocaml
f : 'a -> 'b
g : 'b -> 'c
```

Languages natively know how to glue `f` with `g` because the output of
`f` can be passed, just as it is, to `g`.

```ocaml
let glued x = g (f x)
```

This leads to 2 traits in the OOP's function application:

- We rarely have to worry about it. \
  Even more: we intentionally design our methods so that their signature
  makes the compiler happy. When things have incompatible signatures, we
  write wrappers and adapters to work around the incompatibility.

- We often assume function application is dumb. \
  It just passes a value to the next function, doing nothing else
  meanwhile, and we are happy with that. There are few exceptions:
  indeed, design patterns like Decorator and Aspect Oriented Programming
  are a way to add some logic to method calls.

The farest we go with making things intentionally incompatible and with
adding new functionalities to function application, in OOP, is with
Async calls:

```ocaml
f : 'a -> Task<'b>
g : 'b -> Task<'c>
```

Those functions just don't combine natively. We dare to go this
direction only because it is an easy problem to solve: the language
reserves a special treatment to this case, providing us with the
dedicated keywords `async` and `await`. For example, in C\#:

```csharp
async Task<C> GluedAsync(A x) =>
    await g(await f(x));
```

In a sense, exceptions are also an example of this. If your language did
not implement exceptions, you would need to handle errors like Go does:

- Checking every and each call for returned errors.
- Propagating the error upstream.
- Passing the call stack too.

etc.

Your domain code would be horribly polluted by this error handling
stuff. A way out of this could be to extend the native function
application so that, other than just passing a value from a function to
the next one, it would #emph[also] tackle the error handling
responsibility. Exceptions are so convenient to use because the native
function application does all of this, under the hood.

== Breaking The Rules
<breaking-the-rules>
Both exceptions and the `async`/`await` mechanism are ad-hoc, built-in
solutions. We cannot expect that the native F\# function application
provided a special treatment for parser functions returning `Result`s of
tuples. This is too specific to our peculiar use case.

In fact, in FP it's often the case that we intentionally design the
function signatures ignoring the native gluing mechanism. We take the
freedom to design functions that don't fit together because function
application is easy to extend. And because this gives us the chance to
put some custom logic in the gluing mechanism.

As an FP programmer you don't settle with the dumb native function
application. You want fancier ones: you want them to deal with async
calls, with exceptions. Or to log each call; or, again, to deal with
errors via a `Result` instance instead of exceptions, as in our case. Or
--- why not? --- to do some combinatorial calculation. I stress that in
"You want fancier ones" I intentionally used a plural: in fact, really,
you want a family of function applications, one for each of your
specific use case.

#let link_monads_for_the_rest_of_us = alink(
    "https://arialdomartini.github.io/monads-for-the-rest-of-us",
    [Monads for The Rest of Us],
    
    [A very gentle introduction to Monads, also covering Functors and
     Applicative Functors. It uses mostly F\#.]  )

FP techniques provide a way more generic solution than special
keywords like `async` and `await`. If you read
#link_monads_for_the_rest_of_us, the notion of Applicative Functors
and Monads as an extension of function application should not be new
to you.

Here's the takeaway: if in OOP the signature incompatibility is #emph[a
problem] to be avoided or to be solved by the means of wrappers and
adapters, in FP the same incompatibility is #emph[a design tool] to be
leveraged.

So, let's see how to fix the pyramid of doom we wrote in `parsePerson`
by distilling a new function application. And let's see how this leads
us to re-invent --- yet another time --- Monads.

Take a break, bite an apple, then jump to
#link("/monadic-parser-combinators-6")[the next installment];.
