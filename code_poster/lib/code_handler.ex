defmodule CodeHandler do
  require Logger

  def load_code(path) do
      Logger.debug("Loading code from '#{path}'...")
      read_folder(path)
       |> clean_code
       |> String.codepoints
       |> (fn(code) -> {:ok, code} end).()
  end

 defp clean_code(code) do
      Logger.debug("Joining code...")

      code
      |> String.trim
      |> String.replace(" ", "")
      |> String.replace(~r/\s*\n+\s*/, "")
      |> String.replace(~r/\s/,"")
  end

  defp read_folder(path) do
      File.ls!(path)
      |> Enum.reject( fn x -> File.dir?(path <> "/" <> x) end)
      |> Enum.map( fn x -> File.read!(path <> "/" <> x) end)
      |> Enum.join
  end

end
