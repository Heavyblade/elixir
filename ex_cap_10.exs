defmodule MyList  do
  def flatten([], _acum) do
      []
  end

  def flatten([h | t], acum) when is_list(h)  do

  end

  def flatten([h | t], acum) do

  end
end

MyList.flatten([ 1, [ 2, 3, [4] ], 5, [[[6]]]])
