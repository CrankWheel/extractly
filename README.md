# Extractly

<!--
DO NOT EDIT THIS FILE
It has been generated from the template `README.md.eex` by Extractly (https://github.com/RobertDober/extractly.git)
and any changes you make in this file will most likely be lost
-->

[![Build Status](https://travis-ci.org/RobertDober/extractly.svg?branch=master)](https://travis-ci.org/RobertDober/extractly)
[![Coverage Status](https://coveralls.io/repos/github/RobertDober/extractly/badge.svg?branch=master)](https://coveralls.io/github/RobertDober/extractly?branch=master)
[![Hex.pm](https://img.shields.io/hexpm/v/extractly.svg)](https://hex.pm/packages/extractly)
[![Hex.pm](https://img.shields.io/hexpm/dw/extractly.svg)](https://hex.pm/packages/extractly)
[![Hex.pm](https://img.shields.io/hexpm/dt/extractly.svg)](https://hex.pm/packages/extractly)



##  Mix task to Transform EEx templates in the context of the `Extractly` module.

  This tool serves two purposes.

  1. A simple CLI to basicly `EEx.eval_file/2`

  1. Access to the `Extractly` module (available as binding `xtra` too)

  1. Access to the name of the rendered template with the `template` binding

  The `Extractly` module gives easy access to Elixir metainformation of the application using
  the `extractly` package, notably, _module_  and _function_ documentation.

  This is BTW the raison d'être of this package, simple creation of a `README.md` file with very simple
  access to the projects hex documentation.

  Thusly hexdoc and Github will always be synchronized.

  To see that in action just look at the [`README.md.eex`](README.md.eex) file of this package and compare
  with what you are reading here.


  Example Template:

      Some text
      <%= xtra.functiondoc("M.shiny_function/2") %>
      <%= xtra.moduledoc("String") %>

      More text


### Usage:

    mix xtra [options]... [template]

#### Options:

    --help | -h     Prints short help information to stdout and exits.
    --quiet | -q    No output to stdout or stderr
    --version | -v  Prints the current version to stdout and exits.
    --verbose       Prints additional output to stderr

    --output filename
              The name of the file the rendered template is written to, defaults to the templates'
              name, without the suffix `.eex`

#### Argument:

    template, filename of the `EEx` template to use, defaults to `"README.md.eex"`




### API

  Returns docstring of a module (or nil)
  Ex:

      Extractly.moduledoc("Extractly")
  Returns docstring of a function (or nil)
  Ex:

      iex(1)> Extractly.functiondoc("Extractly.moduledoc/1")
      [ "  Returns docstring of a module (or nil)",
        "  Ex:",
        "", 
        "      Extractly.moduledoc(\"Extractly\")",
        ""
        ] |> Enum.join("\n")

  We can also pass a list of functions to get their docs concatenated

      iex(2)> out = Extractly.functiondoc(["Extractly.moduledoc/1", "Extactly.functiondoc/2"])
      ...(2)> # as we are inside the docstring we required we would need a quine to check for the
      ...(2)> # output, let us simplify
      ...(2)> String.split(out, "\n") |> Enum.take(5)
      [ "  Returns docstring of a module (or nil)",
        "  Ex:",
        "", 
        "      Extractly.moduledoc(\"Extractly\")",
        ""]

  Returns docstring of a macro (or nil)

  Same naming convention for macros as for functions.


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `extractly` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:extractly, "~> 0.1.4"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/extractly](https://hexdocs.pm/extractly).


## Author

Copyright © 2018,9 Robert Dober, robert.dober@gmail.com,

# LICENSE

Same as Elixir, which is Apache License v2.0. Please refer to [LICENSE](LICENSE) for details.

SPDX-License-Identifier: Apache-2.0
