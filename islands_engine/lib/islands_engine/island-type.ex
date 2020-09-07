defmodule IslandsEngine.IslandType do
  @moduledoc false

use DiscUnion

defunion IslandType
  | Atoll in Atom
  | Dot in Atom
  | L_shape in Atom
  | S_shape in Atom
  | Square in Atom
end
