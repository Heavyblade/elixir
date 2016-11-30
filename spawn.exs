defmodule Spawn1 do
  def greet do
      receive do
        {sender, msg} ->
          send sender, {:ok, "Hello, #{msg}"}
      end
  end
end

defmodule Sender do
  def hello do
      pid = spawn(Spawn1, :greet, [])

      send pid, {self, "Cristian"}

      receive do
        {:ok, msg} -> IO.puts msg
      end
  end
end

Sender.hello
