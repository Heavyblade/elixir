defmodule Issues.TablePrinter do
  @moduledoc """
  This modulo will allow to print any List a a table on
  the command line
  """
  def print_table(list) do
      max_id_element      = Enum.max_by( list, fn(x) -> x |> Map.fetch!("id") |> Integer.to_string(10) |> String.length end ) |> Map.fetch!("id") |> Integer.to_string(10) |> String.length
      max_created_element = Enum.max_by( list, fn(x) -> x |> Map.fetch!("created_at") |> String.length end ) |> Map.fetch!("created_at") |> String.length
      max_title_element   = Enum.max_by( list, fn(x) -> x |> Map.fetch!("title") |> String.length end ) |> Map.fetch!("title") |> String.length

      IO.puts fill_blanks("", max_id_element, "-") <> " + " <> fill_blanks("", max_created_element, "-") <> " + " <> fill_blanks("", max_title_element, "-")
      IO.puts fill_blanks("#", max_id_element) <> " | " <> fill_blanks("created_at", max_created_element) <> " | title"
      IO.puts fill_blanks("", max_id_element, "-") <> " + " <> fill_blanks("", max_created_element, "-") <> " + " <> fill_blanks("", max_title_element, "-")

      Enum.each list,
                fn(item) -> IO.puts Enum.join([Map.fetch!(item, "id"), Map.fetch!(item, "created_at"), Map.fetch!(item,"title")], " | ") end
  end

  def fill_blanks(string, size, fill_with \\ " ") do
      Enum.join([string] ++ Enum.map(1..(size - String.length(string)), fn _x -> fill_with end), "")
  end

end
