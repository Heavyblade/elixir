defmodule ImageHandler do
  require Logger

  def load_image(image_path, ratio) do
      Logger.debug("Loading image from '#{image_path}'...")
      transform_image(image_path, ratio) |> Imagineer.load
  end

  def transform_image(path, ratio) do
      resized_path = Path.basename(path) |> String.replace(".", "_rezised.")
      System.cmd("convert", ["-quality", "100", "-resize" ,"#{ (100 + ((1-ratio) * 100)) |> Float.round(2) |> round }%x100%!", path, resized_path ])
      resized_path
  end

  def convert_to_png(path) do
      new_path =  String.replace(path, ".svg", ".png")
      System.cmd("convert", [path, new_path])
      new_path
  end

  def build_svg(texts, %{width: width, height: height}, fontSize) do
      {:svg,
       %{
         xmlns:   "http://www.w3.org/2000/svg",
         style:   "font-family: 'Monaco'; font-size: 20;",
         width:   (width * fontSize),
         height:  (height* fontSize),
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

  @doc """
  iex> ImageHandler.to_hex 50, 150, 250
  "#3296FA"
  iex> ImageHandler.to_hex 255, 0, 128
  "#FF0080"
  """
  def to_hex(r, g, b) do
      "#" <>
      (r |> :binary.encode_unsigned |> Base.encode16) <>
      (g |> :binary.encode_unsigned |> Base.encode16) <>
      (b |> :binary.encode_unsigned |> Base.encode16)
  end
end
