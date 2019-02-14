defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "otherthing"]) == :help
    assert parse_args(["--help", "other"])  == :help
  end

  test "three values returned if three given" do
    assert parse_args(["myUser", "cirrus", "10"]) == {"myUser", "cirrus", 10}
  end

  test "count is default if only two values are given" do
    assert parse_args(["myUser", "cirrus"]) == {"myUser", "cirrus", 4}
  end
end
