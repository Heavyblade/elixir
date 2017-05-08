defmodule NewCodePosterTest do
    use ExUnit.Case
    require NewCodePoster
    doctest NewCodePoster


    test "should create a svg text representation" do
         a = NewCodePoster.pixed_mapper({255, 0, 128}, "j", 1, 1)
         assert {:text, %{x: 12.0, y: 20, fill: "#FF0080"}, "j"} == a
    end

    test "should convert a row of pixels" do
          {mapped, code} = [{50, 150, 250}, {255, 0, 128}, {255, 150, 250}] |> NewCodePoster.row_mapper(["a", "b", "c"], [], 1, 1)
          assert mapped == [{:text, %{x: 12.0, y: 20, fill: "#3296FA"}, "a"}, {:text, %{x: 24.0, y: 20, fill: "#FF0080"}, "b"}, {:text, %{x: 36.0, y: 20, fill: "#FF96FA"}, "c"}]
    end
end
