defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1,
                             sort_into_ascending_order: 1 ]

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

  test "sort ascending orders the correcto way" do
    result = sort_into_ascending_order(fake_created_at_list(["c", "a", "b"]))
    issues = for issue <- result, do: Map.get(issue, "created_at")

    assert issues == ~w{a b c}
  end

  defp fake_created_at_list(values) do
      for value <- values,
      do: %{"created_at" => value, "other_data" => "xxx"}
  end
end
