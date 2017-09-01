defmodule Api.Accounts.Queries do
  use Absinthe.Schema.Notation
  alias Api.{
    Accounts.Resolvers
  }

  object :accounts_queries do

    @desc "Get the currently signed in user, or nil"
    field :current_user, type: :user do
      resolve &Resolvers.current/2
    end

    @desc "Get user by attribute"
    field :user, type: :user do
      arg :id, :integer
      arg :username, :string

      middleware ApiWeb.Middleware.RequireAuthorized
      resolve &Resolvers.user/2
    end

    @desc "Get followees of current or given user"
    field :my_followees, type: list_of(:user_user) do
    resolve &Resolvers.my_followees/2
    end

    @desc "Get all users"
    field :users, type: list_of(:user) do
      middleware ApiWeb.Middleware.RequireAuthorized
      resolve &Resolvers.users/2
    end

    @doc"""
    @desc "Get my users"
    field :my_users, type: list_of(:user) do
      resolve &Resolvers.my_users/2
    end
    """

  end
end
