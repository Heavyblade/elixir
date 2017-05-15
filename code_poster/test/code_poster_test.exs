defmodule CodePosterTest do
  use ExUnit.Case
  doctest CodePoster

  test "should create a svg text representation" do
       a = CodePoster.pixed_mapper({255, 0, 128}, "j", 1, 1)
       assert {:text, %{x: 12, y: 40, style: "fill: #FF0080;"}, "j"} == a
  end

  test "should convert a row of pixels" do
        {mapped, _code} = [{50, 150, 250}, {255, 0, 128}, {255, 150, 250}] |> CodePoster.row_mapper(["a", "b", "c"], [], 1, 1)
        assert mapped == [{:text, %{x: 12, y: 40, style: "fill: #3296FA;"}, "a"}, {:text, %{x: 24, y: 40, style: "fill: #FF0080;"}, "b"}, {:text, %{x: 36, y: 40, style: "fill: #FF96FA;"}, "c"}]
  end
end
