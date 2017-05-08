defmodule NewCodePoster do
  require Logger

  @fontSize 20
  @ratio 0.6

  def execute(code_path \\ "/home/cvasquez/rails/ng2/app/models", image_path \\ "/home/cvasquez/Downloads/user.png") do
      code  = load_code(code_path)
      image = load_image(image_path)
      construct_text_elements(code, image)
      |>
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
  iex> NewCodePoster.to_hex {50, 150, 250}
  "#3296FA"
  iex> NewCodePoster.to_hex {255, 0, 128}
  "#FF0080"
  """
  def to_hex({r, g, b}) do
      "#" <>
      (r |> :binary.encode_unsigned |> Base.encode16) <>
      (g |> :binary.encode_unsigned |> Base.encode16) <>
      (b |> :binary.encode_unsigned |> Base.encode16)
  end

  @doc """
  iex> NewCodePoster.to_hex {50, 150, 250}
  "#3296FA"
  iex> NewCodePoster.to_hex {255, 0, 128}
  "#FF0080"
  """
  def to_hex({r, g, b, a}) do
      "#" <>
      (r |> :binary.encode_unsigned |> Base.encode16) <>
      (g |> :binary.encode_unsigned |> Base.encode16) <>
      (b |> :binary.encode_unsigned |> Base.encode16) <>
      (a |> :binary.encode_unsigned |> Base.encode16)
  end

  @doc """
  Mapping an rgb, a character and a position to a text tuple to be mapped to svg
  iex> NewCodePoster.pixed_mapper({255, 0, 128}, "j", 1, 1)
  {:text, %{x: 12.0, y: 20, fill: "#FF0080"}, "j"}
  """
  def pixed_mapper(rgb, chr, x, y) do
      { :text, %{x: (x * @ratio * @fontSize), y: (@fontSize * y), fill: to_hex(rgb)}, chr }
  end

  def row_mapper([], restCode, row_mapped, _, _) do
      {Enum.reverse(row_mapped), restCode}
  end

  def row_mapper([pixel | rest_row], [ chr | restCode ], row_mapped, x, y) do
      pixel = pixed_mapper(pixel, chr, x, y)
      row_mapper(rest_row, restCode, [ pixel | row_mapped ], x+1, y)
  end

  def image_mapper([], _, _, poster), do: poster

  def image_mapper([row | rest], code, line, poster) do
      {row, rest_code} = row_mapper(row, code, [], 0, line)
      image_mapper(rest, rest_code, line + 1 , poster ++ [row])
  end

  def construct_text_elements(code, %{pixels: pixels}) do
      Logger.debug("Constructing text elements...")
      Logger.debug(inspect(image_mapper(pixels, code, 0, [])))
  end

end
