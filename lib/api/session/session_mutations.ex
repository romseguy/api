defmodule Api.Session.Mutations do
  use Absinthe.Schema.Notation
  alias Api.Session.Resolvers


  object :session_mutations do
    @desc "Login with email and password"
    field :login, type: :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &Resolvers.login/2
    end

    @desc "Register with email, username, and password"
    field :register, type: :session do
      arg :email, non_null(:string)
      arg :username, non_null(:string)
      arg :password, non_null(:string)

      resolve &Resolvers.register/2
    end

    field :logout, type: :query do
      middleware fn res, _ ->
        %{res |
          context: Map.delete(res.context, :current_user),
          value: "logged out",
          state: :resolved
        }
      end
    end
  end
end
