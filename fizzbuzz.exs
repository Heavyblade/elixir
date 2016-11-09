defmodule Fizzbuzz do
  def upto(n) do
      _upto(0, n)
  end

  defp _upto(current, to) when current == to  do
       IO.puts evaluate(current)
  end

  defp _upto(current, to) do
       IO.puts evaluate(current)
       _upto(current+1, to)
  end

  defp evaluate(current) do
       cond do
          rem(current, 3) == 0 and rem(current, 5) == 0 -> "FizzBuzz"
          rem(current, 3) == 0 -> "Fizz"
          rem(current, 5) == 0 -> "Buzz"
          true -> current
       end
  end
end

defmodule Fizzbuzz2 do
  def upto(n) do
      _upto(0, n)
  end

  defp _upto(current, to) when current == to  do
       IO.puts evaluate(current)
  end

  defp _upto(current, to) do
       IO.puts evaluate(current)
       _upto(current+1, to)
  end

  defp evaluate(current) do
       remain = [ rem(current, 3), rem(current,5) ]
       case remain do
         [0,0] -> "FizzBuzz"
         [0,_] -> "Fizz"
         [_,0] -> "Buzz"
          _    -> current
       end
  end
end

defmodule FizzBuzz3 do
  def upto(n) when n > 0, do: 1..n |> Enum.map(&fizzbuzz/1)
  defp fizzbuzz(n), do: _fizzword(n, rem(n, 3), rem(n, 5))

  defp _fizzword(_n, 0, 0), do: "FizzBuzz"
  defp _fizzword(_n, 0, _), do: "Fizz"
  defp _fizzword(_n, _, 0), do: "Buzz"
  defp _fizzword( n, _, _), do: n
end


Fizzbuzz.upto(20)
Fizzbuzz2.upto(20)
