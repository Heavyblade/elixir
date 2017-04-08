defmodule Delivery.PostalCode.Store do
  use GenServer
  alias Delivery.PostalCode.DataParser

  def start_link do
      GenServer.start_link(__MODULE__, %{}, name: :postal_code_store)
  end

  def init(_) do
      geolocation_data = DataParser.parse_data
      {:ok, geolocation_data}
  end

  def get_geolocation(postal_code) do
      GenServer.call(:postal_code_store, {:get_geolocation, postal_code})
  end

  def handle_call({:get_geolocation, postal_code}, _from, geolocation_data) do
      geolocation = Map.get(geolocation_data, postal_code)
      {:reply, geolocation, geolocation_data}
  end

end
