defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true

  def saluda do
  end
end

defmodule Caller do
  def saludame do
    s1 = %Subscriber{name: "Cristian"}
    IO.puts s1.name
  end

  def pattern do
      s1 = %Subscriber{name: "Camilo"}
      %{name: name} = s1
      IO.puts name
  end
end

Caller.saludame
Caller.pattern
