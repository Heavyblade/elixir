defmodule React.Router do
  use React.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

    get "/customers", CustomersController,     :index
    get "/customers/:id", CustomersController, :show

    options "/customers", CustomersController, :options
    options "/customers/:id", CustomersController, :options
  end

  scope "/", React do
    pipe_through :browser # Use the default browser stack

    get "/hello", HelloController, :world
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", React do
  #   pipe_through :api
  # end
end
