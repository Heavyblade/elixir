defmodule MyList do
  def sum(list), do: _sum(list, 0)

  defp _sum([], total), do: total

  defp _sum([ head | tail ], total) do
       _sum(tail, total + head)
  end
end

defmodule MyList2 do
  def sum([]), do: 0

  def sum([head | tail]) do
      head + sum(tail)
  end
end

defmodule Functional do
  def map([], _func), do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]

  def reduce([], value, _), do: value
  def reduce([head | tail], value, fun), do: reduce(tail, fun.(value, head), fun)

  def mapsum(list, fun) do
      map(list, fun) |> reduce(0, &(&1 + &2))
  end

  def max(list) do
      getMax = fn(max, el) -> if ( max < el ), do: max, else: el end
      reduce(list, 0, getMax)
  end
end

# IO.puts MyList.sum([1,2,3,4,5])
# IO.puts MyList2.sum([1,2,3,4,5])
# IO.puts Functional.reduce([1,2,3,4,5], 10, fn(total, elemento) -> total + elemento end)
# IO.puts Functional.reduce([1,2,3,4,5], 10, &(&1+&2))
# IO.puts Functional.mapsum([2,2,2], &(&1*2) )
# IO.puts Functional.max([4,9,7,2])


defmodule Swapper do
  def swap([]), do: []
  def swap([ a, b | tail ]), do: [ b, a | swap(tail) ]
  def swap([_]), do: raise "Can't swap a list with an odd number of elements"
end

defmodule WeatherHistory do
  def for_location_27([]), do: []
  def for_location_27([ [time, 27, temp, rain ] | tail]) do
      [ [time, 27, temp, rain] | for_location_27(tail) ]
  end
  def for_location_27([ _ | tail]), do: for_location_27(tail)
end

defmodule Canvas do
  @defaults [fg: "black", bg: "white", font: "Merriweather"]

  def text(txt, options \\ []) do
      options = Keyword.merge(@defaults, options)
      IO.puts options[:fg]
      IO.puts "Drawing text #{inspect(txt)}"
      IO.puts "Foreground: #{options[:fg]}"
      IO.puts "Background: #{Keyword.get(options, :bg)}"
  end
end

IO.puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
Canvas.text("cristian")
IO.puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
Canvas.text("Camilo", [bg: "blue"])
IO.puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
Canvas.text("Vasquez", fg: "green", font: "Arial")
IO.puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

people = [
          %{ name: "Grumpy",    height: 1.24 },
          %{ name: "Dave",      height: 1.88 },
          %{ name: "Dopey",     height: 1.32 },
          %{ name: "Shaquille", height: 2.16 },
          %{ name: "Sneezy",    height: 1.28 }
]

IO.inspect(for person = %{ height: height } <- people, height > 1.5, do: person)
