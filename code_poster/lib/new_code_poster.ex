defmodule NewCodePoster do

  @doc """
  iex> ElixirPoster.clean_code("if (true) {\\n    bang;\\n}")
  "if (true) { bang; }"
  iex> ElixirPoster.clean_code("{\\n    '    ';\\n}")
  "{ '    '; }"
  iex> ElixirPoster.clean_code("  a \\n bb\\n \\tc\\n    d  ")
  "a bb c d"
  """
  def clean_code(code) do
      Logger.debug("Joining code...")

      code
      |> String.trim
      |> String.replace(~r/\s*\n+\s*/, " ")
      |> String.replace(~r/\s/," ")
  end

  def read_folder(path) do
      File.ls!(path)
      |> Enum.reject( fn x -> File.dir?(path <> "/" <> x) end)
      |> Enum.map( fn x -> File.read!(path <> "/" <> x) end)
      |> Enum.join
  end

  def load_code(path) do
      Logger.debug("Loading code from '#{code_path}'...")
      read_folder(code_path)
       |> clean_code
       |> String.codepoints
  end

  def load_image(image_path) do
      Logger.debug("Loading image from '#{image_path}'...")
      {:ok, image} = Imagineer.load(image_path)
      image
  end

  def execute(code_path, image_path, ratio) do
      code  = read_code(code_path)
      image = load_image(image_path)
      construct_text_elements(code, ratio, image)
  end

  def construct_text_elements(code, ratio, %{width: width, pixels: pixels}) do
      Logger.debug("Constructing text elements...")
      text_elements = pixels
      |> Enum.with_index
      |> Enum.map(get_row_mapper(code, width, ratio))
      |> List.flatten
      %{data | text_elements: text_elements}
  end

end
