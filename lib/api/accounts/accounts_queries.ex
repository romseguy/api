defmodule Api.Accounts.Queries do
  use Absinthe.Schema.Notation
  alias Api.{
    Accounts.Resolvers
  }

  object :accounts_queries do
    @desc "Get all users"
    field :users, type: list_of(:user) do
      middleware ApiWeb.Middleware.RequireAuthorized
      resolve &Resolvers.all/2
    end

    @desc "Get user by id"
    field :user, type: :user do
      arg :id, non_null(:integer)

      middleware ApiWeb.Middleware.RequireAuthorized
      resolve &Resolvers.find/2
    end

    @desc "Get the currently signed in user, or nil"
    field :current_user, type: :user do
      resolve &Resolvers.current/2
    end

    @desc "Get my users"
    field :my_users, type: list_of(:user) do
      resolve &Resolvers.my_users/2
    end
  end
end
