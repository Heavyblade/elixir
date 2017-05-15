defmodule Mix.Tasks.CreatePoster do
  use Mix.Task
  require CodePoster

  @shortdoc "Create an image using a source code"

  def run(args) do
      CodePoster.execute(Enum.at(args, 0), Enum.at(args, 1))
  end
end
