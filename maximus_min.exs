defmodule MinMax do

  def reduce([], value, _), do: value
  def reduce([head | tail], value, fun), do: reduce(tail, fun.(value, head), fun)


  def max([first | list]) do
      getMax = fn(max, el) -> if ( max > el ), do: max, else: el end
      reduce(list, first, getMax)
  end

  def min( [first | list ]) do
      getMin = fn(min, el) -> if ( min < el ), do: min, else: el end
      reduce(list, first, getMin)
  end

end

IO.puts MinMax.max([-52, 56, 30, 29, -54, 0, -110])
