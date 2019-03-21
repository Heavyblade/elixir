defmodule Sequence.Server do

  use GenServer

  # API insterface
  def start_link(initial_number) do
      GenServer.start_link(__MODULE__, initial_number, name: __MODULE__)
  end

  def next_number do
      GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(new_number) do
      GenServer.cast(__MODULE__, {:increment, new_number})
  end

  # Backend interface
  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_call(:next_number, _from, state) do
      {:reply, state, state + 1}
  end

  def handle_cast({:increment, number}, state) do
     {:noreply, state + number}
  end

  def format_status(reason, _pdict_and_state) do
      [data: [{'State', "My current state is #{inspect reason}, and I'm happy"}]]
  end
end
