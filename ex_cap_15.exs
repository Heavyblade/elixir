defmodule LinkExample do
  import :timer, only: [sleep: 1]

  def send_message do
      receive do
        {sender, message} ->
          IO.puts message
          send sender, {:ok, "Hello world"}
          exit(:boom)
      end
  end

  def run do
      proc = spawn_link(LinkExample, :send_message, [])
      send proc, {self(), "Hola soy original"}
      sleep 1000
      receive do
        {:ok, msg} ->
          IO.puts "Me enviar un mensaje #{msg}"
      end
  end
end

LinkExample.run
