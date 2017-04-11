defmodule Challenge do

  @braces %{"(" => ")", "[" => "]", "{" => "}"}

  def valid_braces(braces) do
      [chr | tail] = String.codepoints(braces)
      check(tail, @braces[chr])
  end

  def check([chr | tail], expected) do
      check(tail, @braces[chr])
  end
end
