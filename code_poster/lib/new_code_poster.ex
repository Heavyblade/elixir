defmodule NewCodePoster do
  require Logger

  @fontSize 20
  @ratio 0.6

  def execute(code_path \\ "/home/cvasquez/rails/ng2/app/models", image_path \\ "/home/cvasquez/Downloads/velocity.png") do
      with {:ok, image} <- load_image(image_path),
           {:ok, code}  <- load_code(code_path)
      do
          construct_text_elements(code, image)
          |> build_svg(image)
          |> save_svg("out_test.svg")
          |> convert_to_png
          |> Logger.debug
      else
          err -> err
      end
  end

  def load_image(image_path) do
      Logger.debug("Loading image from '#{image_path}'...")
      transform_image(image_path) |> Imagineer.load
  end

  def transform_image(path) do
      resized_path = Path.basename(path) |> String.replace(".", "_rezised.")
      System.cmd("convert", ["-quality", "100", "-resize" ,"#{ (100 + ((1-@ratio) * 100)) |> Float.round(2) |> round }%x100%!", path, resized_path ])
      resized_path
  end

  def convert_to_png(path) do
      new_path =  String.replace(path, ".svg", ".png")
      System.cmd("convert", [path, new_path])
      new_path
  end

  def build_svg(texts, %{width: width, height: height}) do
      {:svg,
       %{
         xmlns:   "http://www.w3.org/2000/svg",
         style:   "font-family: 'Monaco'; font-size: 20;",
         width:   (width * @fontSize),
         height:  (height* @fontSize),
         "xml:space": "preserve"
       },
       texts}
      |> XmlBuilder.generate
  end

  def save_svg(code, path) do
      Logger.debug("Saving svg to #{path}")
      {:ok, file} = File.open(path, [:write])
      IO.binwrite(file, code)
      File.close(file)
      path
  end

  def clean_code(code) do
      Logger.debug("Joining code...")

      code
      |> String.trim
      |> String.replace(" ", "")
      |> String.replace(~r/\s*\n+\s*/, "")
      |> String.replace(~r/\s/,"")
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
       |> (fn(code) -> {:ok, code} end).()
  end

  @doc """
  iex> NewCodePoster.to_hex 50, 150, 250
  "#3296FA"
  iex> NewCodePoster.to_hex 255, 0, 128
  "#FF0080"
  """
  def to_hex(r, g, b) do
      "#" <>
      (r |> :binary.encode_unsigned |> Base.encode16) <>
      (g |> :binary.encode_unsigned |> Base.encode16) <>
      (b |> :binary.encode_unsigned |> Base.encode16)
  end

  @doc """
  Mapping an rgb, a character and a position to a text tuple to be mapped to svg
  iex> NewCodePoster.pixed_mapper({255, 0, 128}, "j", 1, 1)
  {:text, %{style: "fill: #FF0080;", x: 12, y: 40}, "j"}
  """
  def pixed_mapper({r,g,b}, chr, x, y) do
      { :text, %{x: round(x * @ratio * @fontSize), y: (round(@fontSize * y) + 20), style: "fill: #{to_hex(r,g,b)};"}, chr }
  end

  @doc """
  Mapping an rgb, a character and a position to a text tuple to be mapped to svg
  iex> NewCodePoster.pixed_mapper({255, 0, 128, 250}, "j", 1, 1)
  {:text, %{opacity: "0.98", style: "fill: #FF0080;", x: 12, y: 40}, "j"}
  """
  def pixed_mapper({r,g,b, a}, chr, x, y) do
      { :text, %{x: round(x * @ratio * @fontSize), y: (round(@fontSize * y) + 20), style: "fill: #{to_hex(r,g,b)};", opacity: "#{Float.round(a/255, 2)}"}, chr }
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
      image_mapper(pixels, code, 0, [])
  end

end
