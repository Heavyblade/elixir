defmodule Sequencer.Server do
  use GenServer
  
  def handle_call(:next_number, _from, current_number) do
      {:reply, current_number, current_number + 1}
  end

  def handle_cast(:next_number, current_number) do
      {:noreply, current_number + 1}
  end
end
