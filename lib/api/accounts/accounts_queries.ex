defmodule Api.Accounts.Queries do
  use Absinthe.Schema.Notation
  alias Api.Accounts.Resolvers
  alias ApiWeb.Middleware.RequireAuthorized


  object :accounts_queries do
    @doc"""
    User
    """
    @desc "QUERY the current user"
    field :current_user, type: :user do
      resolve &Resolvers.current/2
    end
    @desc "QUERY an user"
    field :user, type: :user do
      arg :id, :integer
      arg :username, :string

      middleware RequireAuthorized
      resolve &Resolvers.user/2
    end
    @desc "QUERY all users"
    field :users, type: list_of(:user) do
      middleware RequireAuthorized
      resolve &Resolvers.users/2
    end
    @doc"""
    UserUser
    """
    @desc "QUERY my relatives"
    field :my_relatives, type: list_of(:user_user) do
    resolve &Resolvers.my_user_users/2
    end
  end
end
