defmodule Sequence.StashServer do
  use GenServer

  # xxxxxxxx managment xxxxx

  def start(initial_state) do
      start_link(initial_state)
  end

  def set_value(new_value) do
      GenServer.cast(__MODULE__, {:set_value, new_value})
  end

  def get_value do
      GenServer.call(__MODULE__, :get_value)
  end
  # xxxxxxxx internal managment xxxxx

  def init(init_arg) do
    {:ok, init_arg}
  end
  def start_link(initial_state) do
      GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def handle_call(:get_value, _from, current_value) do
    {:reply, current_value, current_value}
  end

  def handle_cast({:set_value, new_value}, _current_value) do
    {:noreply, new_value}
  end
end
