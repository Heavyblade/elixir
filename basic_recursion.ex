defmodule MyList do
  def len([]), do: 0

  def len([_head | tail]) do
    1 + len(tail)
  end

  def add_one([]), do: []

  def add_one([head|tail]), do: [head+1 | add_one(tail)]
end

# IO.puts(MyList.len([1, 2, 3]))
# IO.puts(MyList.len([1, 2]))

MyList.add_one([1,2,3]) |> IO.inspect |> IO.puts

defmodule MyMath do
    def sum([]), do: 0

    def sum([head|tail]) do
        head + sum(tail)
    end
end

defmodule MyRecursion do
    def rec([], value,_), do: value

    def rec([current | tail], value, fun) do
        rec(tail, fun.(current, value), fun)
    end
end

MyMath.sum([1,2,3]) |> IO.puts
MyRecursion.rec([1,2,3], 0, &(&1+&2)) |> IO.puts

# Oficial
969fbb94feb542b71ede6f87fe4d5fa29c789342b0f407474670f0c2489e0a0d
969fbb94feb542b71ede6f87fe4d5fa29c789342b0f407474670f0c2489e0a0d