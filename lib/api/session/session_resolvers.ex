defmodule Api.Session.Resolvers do
  import Logger
  import ApiWeb.ErrorHelpers

  def login(attrs, _info) do
    with {:ok, user} <- Api.Session.authenticate(attrs),
         {:ok, jwt, _ } <- Guardian.encode_and_sign(user, :access) do
      {:ok, %{token: jwt}}
    else
      {:error, message} -> {:error, %{
        message: message,
        operationName: "login"
      }}
    end
  end

  def register(attrs, _info) do
    with {:ok, user} <- Api.Session.register(attrs),
          {:ok, jwt, _ } <- Guardian.encode_and_sign(user, :access)
    do
      {:ok, %{token: jwt}}
    else
      {:error, changeset} ->
        # todo: translation
        errorMap = Ecto.Changeset.traverse_errors(changeset, &translate_error/1)

        errorMessages = Enum.map(errorMap, fn error ->
          {_key, errors} = error
          errors
        end)

        {:error, errorMessages}
    end
  end

end
