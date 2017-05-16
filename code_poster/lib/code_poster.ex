defmodule CodePoster do
  require Logger
  require ImageHandler
  require CodeHandler

  @fontSize 20
  @ratio 0.6

  def execute(code_path, image_path) do
      with {:ok, image} <- ImageHandler.load_image(image_path, @ratio),
           {:ok, code}  <- CodeHandler.load_code(code_path)
      do
            get_needed_code(code, image)
            |> construct_text_elements(image)
            |> ImageHandler.build_svg(image, @fontSize)
            |> ImageHandler.save_svg("out_test.svg")
            |> ImageHandler.convert_to_png
            |> Logger.debug
      else
          err -> err
      end
  end

  def get_needed_code(code, %{width: width, height: height}) do
       Agent.start_link fn -> Stream.cycle(code) |> Enum.take(width * height) end
  end

  def construct_text_elements({:ok, code_pid}, %{pixels: pixels}) do
      Logger.debug("Constructing text elements...")
      image_mapper(pixels, code_pid, 0, [])
  end

  def image_mapper([], _, _, poster), do: poster

  def image_mapper([row | rest], code_pid, line, poster) do
      image_mapper(rest, code_pid, line + 1 , poster ++ [row_mapper({line, row}, code_pid, [], 0)])
  end

  # def image_mapper2(pixels, code_pid, line, poster) do
  #     pixels
  #       |> Enum.with_index
  #       |> Enum.map(&(Task.async(fn -> row_mapper(&1) end)))
  #       |> Enum.map(&(Task.await(&1)))
  # end

  def row_mapper({_, []}, _, row_mapped, _), do: Enum.reverse(row_mapped)

  def row_mapper({y, [pixel | rest_row]}, code_pid, row_mapped, x) do
      pixel = pixed_mapper(pixel, code_pid, x, y)
      row_mapper({y, rest_row}, code_pid, [pixel | row_mapped], x+1)
  end

  def get_chr(code_pid) do
      Agent.get_and_update(code_pid, fn [chr | restCode] -> {chr, restCode} end)
  end

  @doc """
  Mapping an rgb, a character and a position to a text tuple to be mapped to svg
  iex> CodePoster.pixed_mapper({255, 0, 128}, "j", 1, 1)
  {:text, %{style: "fill: #FF0080;", x: 12, y: 40}, "j"}
  """
  def pixed_mapper({r,g,b}, code_pid, x, y) do
      { :text, %{x: round(x * @ratio * @fontSize), y: (round(@fontSize * y) + 20), style: "fill: #{ImageHandler.to_hex(r,g,b)};"}, get_chr(code_pid) }
  end

  @doc """
  Mapping an rgb, a character and a position to a text tuple to be mapped to svg
  iex> CodePoster.pixed_mapper({255, 0, 128, 250}, "j", 1, 1)
  {:text, %{opacity: "0.98", style: "fill: #FF0080;", x: 12, y: 40}, "j"}
  """
  def pixed_mapper({r,g,b, a}, code_pid, x, y) do
      { :text, %{x: round(x * @ratio * @fontSize), y: (round(@fontSize * y) + 20), style: "fill: #{ImageHandler.to_hex(r,g,b)};", opacity: "#{Float.round(a/255, 2)}"}, get_chr(code_pid) }
  end

end
