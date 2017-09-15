defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :graphql do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug ApiWeb.Context
    plug ApiWeb.Locale
  end

  scope "/graphql" do
    pipe_through :graphql

    forward "/", Absinthe.Plug,
      schema: ApiWeb.Schema
  end

  forward "/", Absinthe.Plug.GraphiQL,
    schema: ApiWeb.Schema
end
