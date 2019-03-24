defmodule Sequence.SubSupervisor do
    use Supervisor

    def start_link() do
        {:ok, _pid} = Supervisor.start_link __MODULE__, []
    end

    def init(_arg) do
        child_processes = [worker(Sequence.Server, [])]
        Supervisor.init child_processes, strategy: :one_for_one
    end
end
