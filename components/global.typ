#let apply-global-styles(body) = {
    set page(
        paper: "a5",
        margin: (
            inside: 2.5cm,
            outside: 2cm,
            y: 2cm
        )
    )

    [#body]
}
