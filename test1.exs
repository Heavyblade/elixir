defmodule ListConcat do
  def list_concat(list1, list2) do
      IO.puts inspect(list1++list2)
  end
end

defmodule Sum do
  def suma(uno, dos, tres) do
      IO.puts inspect uno + dos + tres
  end

end

ListConcat.list_concat [:uno, :dos], [:tres, :cuatro]
Sum.suma(1,2,3)
