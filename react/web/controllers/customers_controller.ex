defmodule CustomersController do
  use React.Web, :controller
  require Poison
  require Logger

  def index(conn, _params) do
      json conn, read_json()
  end

  def show(conn, params) do
      json conn, Enum.find(read_json(), fn(x) -> x["id"] == elem(Integer.parse(params["id"]), 0) end)
  end

  def read_json do
      File.read!("#{File.cwd!()}/web/templates/customers/index.json") |> Poison.decode!
  end
end
