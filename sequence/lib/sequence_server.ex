defmodule Sequence.Server do

  use GenServer

  # API insterface
  def start_link do
      GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def next_number do
      GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(new_number) do
      GenServer.cast(__MODULE__, {:increment, new_number})
  end

  # Backend interface
  def init(_init_arg) do
    {:ok, Sequence.StashServer.get_value}
  end

  def handle_call(:next_number, _from, _state) do
      current_number = Sequence.StashServer.get_value + 1
      Sequence.StashServer.set_value(current_number)
      {:reply, current_number, current_number}
  end

  def handle_cast({:increment, number}, _state) do
     (Sequence.StashServer.get_value + number) |> Sequence.StashServer.set_value
     {:noreply, Sequence.StashServer.get_value}
  end

  def format_status(reason, _pdict_and_state) do
      [data: [{'State', "My current state is #{inspect reason}, and I'm happy"}]]
  end
end
