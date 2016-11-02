defmodule MyList  do

  def flatten(list) do
      _flatten(list, [])
  end

  def _flatten([],acum) do
      acum
  end

  def _flatten([h | t], acum) when is_list(h)  do
      _flatten(t, acum ++ h)
  end

  def _flatten([h | t], acum) do
      _flatten(t, acum ++ [h])
  end
end

IO.puts inspect(MyList.flatten([ 1, [ 2, 3, [4] ], 5, [[[6]]]]))
IO.puts inspect( MyList.flatten([1,2,3,[4,5],6]) )
