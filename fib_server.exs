defmodule FibServer do

  def fib(scheduler) do
      send scheduler, {:ready, self()}
      receive do
          {:fib, n, client} ->
            send client, {:answer, n, fib_calc(n), self()}
          {:shutdown} ->
            exit(:normal)
       end
  end

  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n-1) + fib_calc(n-2)

end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
      (1..num_processes)
      |> Enum.map(fn(_) -> spawn(module, fun, [self]) end)
      |> schedule_processes(to_calculate, [])
  end
end
