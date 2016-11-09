defmodule Excep do

  def ok!({:ok, data}), do: data

  def ok!(_data) do
      raise "Hola mundo"
  end

end

Excep.ok! File.open("somefile")
