defmodule CodePoster.Mixfile do
  use Mix.Project

  def project do
    [app: :code_poster,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     docs: [main: "MyApp", # The main page in the docs
             logo: "/home/cvasquez/Downloads/user.png",
             extras: ["README.md"]]
   ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:imagineer, "~> 0.3.0"},
     {:xml_builder, "~> 0.0.9"},
     {:ex_doc, "~> 0.14", only: :dev, runtime: false}]
  end
end
