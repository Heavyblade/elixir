defmodule NewCodePoster do
  require Logger

  def execute(code_path, image_path, ratio) do
      code  = load_code(code_path)
      image = load_image(image_path)
      construct_text_elements(code, ratio, image)
  end

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
      Logger.debug("Loading code from '#{path}'...")
      read_folder(path)
       |> clean_code
       |> String.codepoints
  end

  def load_image(image_path) do
      Logger.debug("Loading image from '#{image_path}'...")
      {:ok, image} = Imagineer.load(image_path)
      image
  end

  @doc """
  iex> ElixirPoster.to_hex {50, 150, 250}
  "#3296FA"
  iex> ElixirPoster.to_hex {255, 0, 128}
  "#FF0080"
  """
  def to_hex({r, g, b}) do
      "#" <>
      (r |> :binary.encode_unsigned |> Base.encode16) <>
      (g |> :binary.encode_unsigned |> Base.encode16) <>
      (b |> :binary.encode_unsigned |> Base.encode16)
  end

  @doc """
  iex> ElixirPoster.to_hex {50, 150, 250}
  "#3296FA"
  iex> ElixirPoster.to_hex {255, 0, 128}
  "#FF0080"
  """
  def to_hex({r, g, b, a}) do
      "#" <>
      (r |> :binary.encode_unsigned |> Base.encode16) <>
      (g |> :binary.encode_unsigned |> Base.encode16) <>
      (b |> :binary.encode_unsigned |> Base.encode16) <>
      (a |> :binary.encode_unsigned |> Base.encode16)
  end

  def pixed_mapper({r,g,b}, x, y) do
      { :text, %{x: 100, y: 100, fill: "#{to_hex(r,g,b)}"}, chr }
  end

  def row_mapper([], restCode, row_mapped, x, y), do: {row_mapped, restCode}

  def row_mapper([pixel | rest_row], [ chr | restCode ], row_mapped, x, y) do
       pixel = pixed_mapper(pixel, chr, x, y)
       row_mapper(rest_row, restCode, [ pixel | row_mapped ], y, x+1)
  end

  def image_mapper([], code, poster, line), do: poster

  def image_mapper([row | rest], restCode, line, poster) do
      {row, code} = row_mapper(row, restCode, [], 0, line)
      image_mapper(rest, code, line + 1 , [ row | poster ] )
  end

  def construct_text_elements(code, ratio, %{pixels: pixels}) do
      Logger.debug("Constructing text elements...")
      row_mapper(pixels, code, 0, [])
  end

end
