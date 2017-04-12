defmodule Challenge do

  @braces    %{"(" => ")", "[" => "]", "{" => "}"}
  @openers   ["(", "{", "["]

  def valid_braces(braces_string) do
      length(check(String.codepoints(braces_string), [])) == 0
  end

  defp check([], to_close) do
       to_close
  end

  defp check([ chr | tail], to_close) do
       if Enum.member?(@openers, chr) do
          check(tail, [ @braces[chr] | to_close ])
       else
           if chr == List.first(to_close) do
              check(tail, tl(to_close))
           else
              check(tail, [chr | to_close])
           end
       end
  end
end

IO.puts Challenge.valid_braces( "(){}[]" )
IO.puts Challenge.valid_braces( "(}" )
IO.puts Challenge.valid_braces( "[(])" )
IO.puts Challenge.valid_braces( "([{}])" )
