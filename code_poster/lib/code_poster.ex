defmodule CodePoster do
  require Logger
  require ImageHandler
  require CodeHandler

  @fontSize 20
  @ratio 0.6

  def execute(code_path \\ "/home/cvasquez/rails/ng2/app/models", image_path \\ "/home/cvasquez/Downloads/velocity.png") do
      with {:ok, image} <- ImageHandler.load_image(image_path, @ratio),
           {:ok, code}  <- CodeHandler.load_code(code_path)
      do
          construct_text_elements(code, image)
            |> ImageHandler.build_svg(image, @fontSize)
            |> ImageHandler.save_svg("out_test.svg")
            |> ImageHandler.convert_to_png
            |> Logger.debug
      else
          err -> err
      end
  end

  def construct_text_elements(code, %{pixels: pixels}) do
      Logger.debug("Constructing text elements...")
      image_mapper(pixels, code, 0, [])
  end

  def image_mapper([], _, _, poster), do: poster

  def image_mapper([row | rest], code, line, poster) do
      {row, rest_code} = row_mapper(row, code, [], 0, line)
      image_mapper(rest, rest_code, line + 1 , poster ++ [row])
  end

  def row_mapper([], restCode, row_mapped, _, _) do
      {Enum.reverse(row_mapped), restCode}
  end

  def row_mapper([pixel | rest_row], [chr | restCode], row_mapped, x, y) do
      pixel = pixed_mapper(pixel, chr, x, y)
      row_mapper(rest_row, restCode, [pixel | row_mapped], x+1, y)
  end

  @doc """
  Mapping an rgb, a character and a position to a text tuple to be mapped to svg
  iex> CodePoster.pixed_mapper({255, 0, 128}, "j", 1, 1)
  {:text, %{style: "fill: #FF0080;", x: 12, y: 40}, "j"}
  """
  def pixed_mapper({r,g,b}, chr, x, y) do
      { :text, %{x: round(x * @ratio * @fontSize), y: (round(@fontSize * y) + 20), style: "fill: #{ImageHandler.to_hex(r,g,b)};"}, chr }
  end

  @doc """
  Mapping an rgb, a character and a position to a text tuple to be mapped to svg
  iex> CodePoster.pixed_mapper({255, 0, 128, 250}, "j", 1, 1)
  {:text, %{opacity: "0.98", style: "fill: #FF0080;", x: 12, y: 40}, "j"}
  """
  def pixed_mapper({r,g,b, a}, chr, x, y) do
      { :text, %{x: round(x * @ratio * @fontSize), y: (round(@fontSize * y) + 20), style: "fill: #{ImageHandler.to_hex(r,g,b)};", opacity: "#{Float.round(a/255, 2)}"}, chr }
  end

end
