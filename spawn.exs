# defmodule Spawn1 do
#   def greet do
#       receive do
#         {sender, msg} ->
#           send sender, {:ok, "Hello, #{msg}"}
#       end
#   end
# end
#
# defmodule Sender do
#   def hello do
#       pid = spawn(Spawn1, :greet, [])
#
#       send pid, {self, "Cristian"}
#
#       receive do
#         {:ok, msg} -> IO.puts msg
#       end
#   end
# end


defmodule Test do
    def hello do
        receive do
           {sender, msg} -> send sender, {:ok, msg}
        end
    end
end

defmodule Caller do
    def call(msg) do
        pid = spawn(Test, :hello, [])
        send pid, {self(), msg}

        receive do
            {:ok, message} -> IO.puts message
        end
    end
end

Caller.call("Hello world")
