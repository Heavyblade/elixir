defmodule SpawnLink do
  def say_hello do
      receive do
        {sender, message} ->
          IO.puts "Sending message"
          send sender, "yes i have receive you message '#{message}''"
          send sender, "another one"
          send sender, "and last one"
          exit(:bom)
      end
  end
end

defmodule OriginalProcess do
  import :timer, only: [sleep: 1]

  def spawn_another do
      spawnable = spawn_link SpawnLink, :say_hello, []

      send spawnable, {self(), "call me"}
      sleep(3000)
      receive_messages()
  end

  def receive_messages do
      receive do
        msg ->
          IO.puts "xxxx #{inspect msg}"
          receive_messages()
        after 1000 ->
          IO.puts "Finishing"
      end
  end
end

OriginalProcess.spawn_another
