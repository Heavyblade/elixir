defmodule Sequence.MainSupervisor do
  use Supervisor

  def start_link(intial_number) do
      result = {:ok, sup_pid} = Supervisor.start_link(__MODULE__,[intial_number])
  end

  def start_workers(sup, initial_number) do
      # first stash de stash server
      {:ok, stash_pid} = Supervisor.start_child(sup, worker(Sequence.StashServer, [initial_number]))
  end
end
