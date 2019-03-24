defmodule Sequence.MainSupervisor do
  use Supervisor

  def start_link(intial_number) do
      result = {:ok, sup_pid} = Supervisor.start_link(__MODULE__,[])
      start_workers(sup_pid, intial_number)
      result
  end

  def start_workers(sup, initial_number) do
      # first stash de stash server
      Supervisor.start_child(sup, worker(Sequence.StashServer, [initial_number]))
      Supervisor.start_child(sup, worker(Sequence.SubSupervisor, []))
  end

  def init(_) do
      Supervisor.init [], strategy: :one_for_one
  end
end
