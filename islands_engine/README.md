# IslandsEngine

**TODO: Add description**

## creation via 
mix new islands_engine --sup

## plugins
vscode-elixir
https://marketplace.visualstudio.com/items?itemName=mjmcloug.vscode-elixir

Elixir Test 
https://marketplace.visualstudio.com/items?itemName=samuel-pordeus.elixir-test

ElixirLS
https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `islands_engine` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:islands_engine, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/islands_engine](https://hexdocs.pm/islands_engine).

## learned
### iex
iex -S mix
alias IslandsEngine.Coordinate
alias IslandsEngine.{Coordinate, Guesses}
r Island => recomplile
:miss = Island.guess(dot, coordinate) => only works, when guess returns the same type (:miss)


### elixir language
%IslandsEngine.Coordinate{col: 5, row: 2}
this is like: new Coordinate{col = 5, row = 2} in C#
Can I enforce using the constructor?

{:ok, coordinate1} = Coordinate.new(1, 1) // Destucture!
guesses = update_in(guesses.hits, &MapSet.put(&1, coordinate1))

map:
offsets = [{0, 0}, {0, 1}, {1, 0}, {1, 1}]
Enum.map(offsets, fn {row_offset, col_offset} ->
  Coordinate.new(row + row_offset, col + col_offset)
end)

def new(type, %Coordinate{} = upper_left) do
No strong type-system
Island.new(:wrong, coordinate)
compiles
How can I define: 
def new(%IslandType = type, %Coordinate{} = upper_left) do

Questions:
why dont all tests run?
what does the "%" stand for?
  defines type parameters?

when do I use ":"?
Linter?

guess isn't a pure function!


