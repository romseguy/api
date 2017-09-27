defmodule ApiWeb.Middleware.RequireAuthorized do
  @behaviour Absinthe.Middleware

  @moduledoc """
  Middleware to require authenticated user
  https://hexdocs.pm/absinthe/Absinthe.Middleware.html
  """

  def call(resolution, _config) do
    case resolution.context do
      %{current_user: _} ->
        resolution
      _ ->
        Absinthe.Resolution.put_result(resolution, Api.Session.unauthorized())
    end
  end
end
