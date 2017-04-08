defmodule Magnet do

    def doubles(k, n) do
        Enum.reduce(1..k, 0, fn(x, acc) ->
          acc + Enum.reduce(1..n, 0, fn(y, accy) -> accy + (1 / (x * :math.pow((1+y), 2*x)) ) end)
        end)
    end

end

IO.puts Magnet.doubles(1,3)
IO.puts Magnet.doubles(1,10)
IO.puts Magnet.doubles(10,100)
