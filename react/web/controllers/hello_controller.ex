defmodule React.HelloController do
  use React.Web, :controller

  def world(conn, _params) do
      render conn, "world.html"
  end
end
