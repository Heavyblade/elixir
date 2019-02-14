defmodule MyList do
  def length([]), do: 0
  def length([_ | list]) do
      1 + MyList.length(list)
  end
end

defmodule MySum do
  def sum(0), do: 0
  def sum(n) do
      n + MySum.sum(n-1)
  end
end

defmodule Guard do
  def what_is(x) when is_number(x) do
    IO.puts "#{x} is a number"
  end

  def what_is(x) when is_list(x) do
    IO.puts "#{x} is a list"
  end

  def what_is(x) when is_atom(x) do
    IO.puts "#{x} is a atom"
  end
end


IO.puts(MyList.length([1,2,3,4]))
IO.puts(MySum.sum(5))
IO.puts(Guard.what_is(5))
IO.puts(Guard.what_is(:hola))
IO.puts(to_string(MySum))
