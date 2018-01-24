[
  inputs: ["mix.exs", "{config,lib,test}/**/*.{ex,exs}"],
  line_length: 79,
  # Phoenix-specific macro-like functions that are not covered out of the box
  # by the formatter.
  locals_without_parens: [
    get: :*,
    pipe_through: :*,
    plug: :*,
    render: :*,
    socket: :*,
    transport: :*
  ]
]
