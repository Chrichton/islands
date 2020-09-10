# IslandsEngine

**TODO: Add description**

## creation via 
mix new islands_engine --sup

## Tools
Credo: https://github.com/rrrene/credo

## plugins
vscode-elixir
https://marketplace.visualstudio.com/items?itemName=mjmcloug.vscode-elixir

Elixir Test 
https://marketplace.visualstudio.com/items?itemName=samuel-pordeus.elixir-test

Jump between Test and Impl: Cmd + Shift + J
Run all tests on file     : Cmd + Shift + K, F
Run test at cursor        : Cmd + Shift + K, C
Run all tests in a folder : Cmd + Shift + K, D
Run test suite            : Cmd + Shift + K, S

ElixirLS
https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls

Enable Format on save: Alt + Shift + F

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

@board_range 1..10 => @??

def new(row, col)  when row in(@board_range) and col in(@board_range), do:
    {:ok, %Coordinate{row: row, col: col}}
def new(_row, _col), do: {:error, :invalid_coordinate} => def for row,col !in range?

:ok => Atom
%
@
https://elixir-lang.org/getting-started/introduction.html

-> vs. <-

