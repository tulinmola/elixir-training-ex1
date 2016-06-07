defmodule Ex1.Router do
  use Ex1.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Ex1 do
    pipe_through :browser # Use the default browser stack

    post "/populator", PopulatorController, :populate

    # resources "/movies", MovieController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ex1 do
  #   pipe_through :api
  # end
end
