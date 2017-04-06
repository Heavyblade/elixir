defmodule Magnet do

    def doubles(k, n) do
        Enum.reduce(1..k, 0, fn(x, acc) ->
               y = acc + ( 1 / :math.pow( 1 + (0.1 + n/10), 2)  )
              IO.puts y
              y
        end)
    end

end

IO.puts Magnet.doubles(1,3)
