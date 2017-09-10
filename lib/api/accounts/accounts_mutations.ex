defmodule Api.Accounts.Mutations do
  use Absinthe.Schema.Notation
  alias Api.Accounts.Resolvers
  alias ApiWeb.Middleware.RequireAuthorized


  object :accounts_mutations do
    @doc"""
    User
    """
    @desc "UPDATE the current user"
    field :update_user, type: :user do
      arg :user, :update_user_attrs

      middleware RequireAuthorized
      resolve &Resolvers.update/2
    end
    @doc"""
    UserUser
    """
    @desc "CREATE a relationship with a user"
    field :create_user_user, type: :user_user do
      arg :id, :integer
      arg :user, :create_user_user_attrs

      middleware RequireAuthorized
      resolve &Resolvers.create_user_user/2
    end
  end
end
