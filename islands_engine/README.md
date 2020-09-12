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

### Phoenix 1.5.4
mix archive.install hex phx_new 1.5.4

mix phx.new islands_interface --no-ecto


## learned
### iex
iex -S mix
alias IslandsEngine.Coordinate
alias IslandsEngine.{Coordinate, Guesses}
r Island => recompile
c "lib/islands_interface_web/channels/game_channel.ex" => compile file
:miss = Island.guess(dot, coordinate) => only works, when guess returns the same type (:miss)
state_data = :sys.get_state(game) => gets state from GenServer
state_data = :sys.replace_state(game, 
                fn state_data -> %{state_data | rules: %Rules{state: :player1_turn}}
              end)

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

### @ defines Compile-Time Constants
@board_range 1..10

### when = Guards
def new(row, col)  when row in(@board_range) and col in(@board_range), do:
    {:ok, %Coordinate{row: row, col: col}}

### pattern matching for the case that row,col !in range?
def new(_row, _col), do: {:error, :invalid_coordinate}

### : definesAtom
:ok 

### Tuple
{a, b}

### Keyword list
List of tuples, where the first item of the tuple is an atom
[{:a, 1}, {:b, 2}]
Syntactic sugar: [a: 1, b: 2]

### % constructs and defines a Map = Dictionary in Swift
%{:a => 1, 2 => :b}

### a Struct is a "bare" Map
The keys (atoms) are the members of the Struct
Example Coordinate: defstruct [:row, :col]
Syntactic sugar: coordinate.row accesses :row key

### MapSet = Set in Swift

### Good read
https://elixir-lang.org/getting-started/introduction.html

-> vs. <-

## OTP Registry:
def via_tuple(name), do: {:via, Registry, {Registry.Game, name}}

via = Game.via_tuple("Lena")
{:ok, game} = GenServer.start_link(Game, "Lena", name: via)

## OTP Sending and receiving Messages
iex> self()

iex> send(self(), "Hello World!")

iex> receive do
...> msg -> "Here's the message: #{msg}" 
...> after 100 -> "Nothing to see here." 
...> end

## OTP Fault tolerance
iex> spawned = spawn(DemoProc, :loop, [])
iex> Process.alive?(spawned)
iex> send(spawned, "Hello World!")
Process.exit(spawned, :kaboom)

## Applications

### Applications are a kind of libraries you can put together
:application.which_applications

iex -S mix run --no-start
Application.start(:islands_engine)
Application.stop(:islands_engine)

:application.ensure_all_started(:islands_engine)