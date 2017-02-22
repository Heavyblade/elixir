defmodule CodePosterTest do
  use ExUnit.Case
  doctest CodePoster

  test "the truth" do
    path = CodePoster.hello
    assert path == "/hello"
  end
end
