defmodule Exer do
  def float_to_string(float) do
      IO.puts Float.to_string(float)
  end
  def two_decimals(float) do
      float_to_string(Float.round(float, 2))
      Float.round(float, 2) |> float_to_string
  end

  def get_os_en_var(name) do
     env = System.get_env(name)
     IO.puts env
  end

  def file_extension(path) do
      IO.puts Path.extname(path)
  end
  def current_process_id do
      IO.puts self
  end
end

Exer.float_to_string(2.3343434)
Exer.two_decimals(7.1112233)
Exer.get_os_en_var("EDITOR")
Exer.file_extension("/path/to/my_elexir.exs")
Exer.current_process_id
