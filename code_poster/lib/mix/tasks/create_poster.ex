defmodule Mix.Tasks.CreatePoster do
  use Mix.Task
  require NewCodePoster

  @shortdoc "Create an image using a source code"

  def run(args) do
      NewCodePoster.execute(Enum.at(args, 0), Enum.at(args, 1))
  end
end
