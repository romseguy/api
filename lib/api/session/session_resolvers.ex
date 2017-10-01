defmodule Api.Session.Resolvers do
  import Logger
  import ApiWeb.ErrorHelpers

  def login(attrs, _info) do
    with {:ok, user} <- Api.Session.authenticate(attrs),
         {:ok, jwt, _ } <- Guardian.encode_and_sign(user, :access) do
      {:ok, %{token: jwt}}
    end
  end

  def register(attrs, _info) do
    with {:ok, user} <- Api.Session.register(attrs),
          {:ok, jwt, _ } <- Guardian.encode_and_sign(user, :access)
    do
      {:ok, %{token: jwt}}
    else
      {:error, changeset} -> {:error, changeset}
    end
  end

end
