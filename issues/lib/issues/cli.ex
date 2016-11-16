defmodule Issues.CLI do
  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """

  def run(argv) do
      argv
      |> parse_args
      |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.
  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.
  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """

  def parse_args(argv) do
      parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

      case parse do
            { [help: true], _, _ }           -> :help
            { _, [user, project, count], _ } -> { user, project, String.to_integer(count) }
            { _, [user, project], _ }        -> { user, project, @default_count }
            _ -> :help
      end
  end


  def process(:help) do
      IO.puts """
      usage: issues <user> <project> [ count | #{ @default_count } ]
      """
  end

  def process({user, project, count}) do
      Issues.GithubIssues.fetch(user, project)
      |> decode_response
      |> convert_to_list_of_maps
      |> sort_into_ascending_order
      |> Enum.take(count)
      |> print_table
  end

  def convert_to_list_of_maps(list) do
      list
      |> Enum.map(&Enum.into(&1, Map.new))
  end

  def sort_into_ascending_order(list) do
      Enum.sort list, fn(i1,i2) -> i1["created_at"] <= i2["created_at"]  end
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
      { _, message } = List.keyfind(error, "message", 0)
      IO.puts "Error fetching from Github: #{message}"
      System.halt(2)
  end

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
