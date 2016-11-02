defmodule MyEnum do
  def all?([], _ss) do
      true
  end

  def all?([ head | tail ], func) do
      if func.(head) do
          all?(tail, func)
      else
          false
      end
  end

  def each([ head | tail ], func) do
      [ func.(head) | each(tail, func) ]
  end

  def each([], _fun) do
      []
  end

end


#IO.puts MyEnum.all?([3,4,5], fn(el) -> el > 1 end )
#IO.puts MyEnum.all?([3,4,1], fn(el) -> el > 1 end )

#IO.puts MyEnum.each([13.0, 22.0, 35.0], fn(el) -> el + 2 end )

function = fn (x, acc) ->
               IO.puts acc
               x - acc
           end

List.foldl([1,2,3,4], 0, function)
