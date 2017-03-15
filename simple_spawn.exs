pid = spawn fn  ->
        receive do
          {:hello, msg} -> IO.puts msg
        end
      end
pid2 = spawn fn -> 1 + 2 end

IO.puts Process.alive?(pid2)
IO.puts Process.alive?(pid)
send pid, {:hello, "Cristian hola"}
IO.puts Process.alive?(pid)
