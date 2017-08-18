defmodule Api.Session do
  @moduledoc """
  The boundary for the Session system.
  """
  import Logger

  alias Api.{Accounts}

  @doc """
  Returns the user associated with `attrs.email` if hashed `attrs.password` matches `user.password_hash`.
  """
  def authenticate(attrs) do
    user = Accounts.get_user(%{"email" => attrs.email})

    case check_password(user, attrs.password) do
      true -> {:ok, user}
      _ -> {:error, "invalid_credentials"}
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end

  def register(attrs) do
    Accounts.create_user(attrs)
  end

  def unauthorized() do
    {:error, %{message: "Not Authorized", status: 401}}
  end
end
