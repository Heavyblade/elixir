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
            |> image_mapper(image)
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

  def image_mapper({:ok, code_pid}, %{pixels: pixels}) do
      Logger.debug("Constructing text elements...")
      pixels
      |> Enum.with_index(1)
      # |> Enum.map(fn element -> row_mapper(element, code_pid) end)
      |> Enum.map(fn element -> Task.async( fn -> row_mapper(element, code_pid) end ) end)
      |> Enum.map(&Task.await/1)
  end

  def row_mapper({row, y}, code_pid) do
      row
      |> Enum.with_index
      |> Enum.map(&( pixed_mapper(elem(&1, 0), code_pid, elem(&1, 1), y) ))
  end

  def get_chr(code_pid) do
      Agent.get_and_update(code_pid, fn [chr | restCode] -> {chr, restCode} end)
  end

  @doc """
  Creates SVG text element.

  Maps an rgb tuple, a character and a position to a tuple that represents an svg text element.

  iex> {:ok, pid} = Agent.start_link fn -> ["h","e", "l", "l", "o"] end
  iex> CodePoster.pixed_mapper({255, 0, 128}, pid, 1, 1)
  {:text, %{style: "fill: #FF0080;", x: 12, y: 40}, "h"}
  """
  def pixed_mapper({r,g,b}, code_pid, x, y) do
      { :text, %{x: round(x * @ratio * @fontSize), y: (round(@fontSize * y) + 20), style: "fill: #{ImageHandler.to_hex(r,g,b)};"}, get_chr(code_pid) }
  end

  @doc """
  Creates SVG text element.

  Maps an rgb tuple, a character and a position to a tuple that represents an svg text element with opacity.

  iex> {:ok, pid} = Agent.start_link fn -> ["h","e", "l", "l", "o"] end
  iex> CodePoster.pixed_mapper({255, 0, 128, 250}, pid, 1, 1)
  {:text, %{opacity: "0.98", style: "fill: #FF0080;", x: 12, y: 40}, "h"}
  """
  def pixed_mapper({r,g,b, a}, code_pid, x, y) do
      { :text, %{x: round(x * @ratio * @fontSize), y: (round(@fontSize * y) + 20), style: "fill: #{ImageHandler.to_hex(r,g,b)};", opacity: "#{Float.round(a/255, 2)}"}, get_chr(code_pid) }
  end

end
