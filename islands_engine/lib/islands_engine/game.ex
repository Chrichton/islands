defmodule IslandsEngine.Game do
  @moduledoc false

  use GenServer

  # public interface (synchronous call)
  def demo_call(pid) do
    GenServer.call(pid, :demo_call)
  end

  # public interface (asynchronous call)
  def demo_cast(pid, new_value) do
    GenServer.cast(pid, {:demo_cast, new_value})
  end

  def handle_info(:first, state) do
    IO.puts "This message has been handled by handle_info/2, matching on :first."
    {:noreply, state}
  end

  def handle_call(:demo_call, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:demo_cast, new_value}, state) do
    {:noreply, Map.put(state, :test, new_value)}
  end

end
