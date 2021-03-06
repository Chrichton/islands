# IslandsInterface

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Install Node.js dependencies with `npm install` inside the `assets` directory
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

## Installation

### Phoenix 1.5.4

mix archive.install hex phx_new 1.5.4

### For Alt-Shift-F

sudo gem install htmlbeautifier

## Create Phoenix-App

mix phx.new islands_interface --no-ecto

## iex

:application.which_applications

### start web-server

iex -S mix phx.server
alias IslandsEngine.GameSupervisor
Supervisor.which_children(GameSupervisor)

## Commandline

mix deps.tree

## Questions:

### <>
def join("game:" <> _player, _payload, socket) do
Answer: <> is the concat String operator

### inspect
{:reply, {:error, %{reason: inspect(reason)}}, socket}
Answer: inspect converts the reason-structure into a string-representation.
        This way, it hasn´t to be serialized

## Errata

### Phoenix no longer uses Brunch, but webpack

in app.js register phoenix:

import phoenix from 'phoenix'
window.phoenix = phoenix

after that phoenix ist available via 
window.Phoenix 
using the browser-javascript console

var socket = new window.Phoenix.Socket("/socket", {})

------

via = IslandsEngine.Game.via_tuple("moon")
state_data = :sys.get_state(via)