defmodule CodePosterTest do
  use ExUnit.Case
  doctest CodePoster

  test "should create a svg text representation" do
       {:ok, pid} = Agent.start_link fn -> ["h","e", "l", "l", "o"] end
       a = CodePoster.pixed_mapper({255, 0, 128}, pid, 1, 1)
       assert {:text, %{x: 12, y: 40, style: "fill: #FF0080;"}, "h"} == a
  end

  test "should convert a row of pixels" do
       {:ok, pid} = Agent.start_link fn -> ["h","e", "l", "l", "o"] end
       mapped = {[{50, 150, 250}, {255, 0, 128}, {255, 150, 250}], 1} |> CodePoster.row_mapper(pid)
       assert mapped == [{:text, %{x: 0, y: 40, style: "fill: #3296FA;"}, "h"}, {:text, %{x: 12, y: 40, style: "fill: #FF0080;"}, "e"}, {:text, %{x: 24, y: 40, style: "fill: #FF96FA;"}, "l"}]
  end
end
