defmodule Api.Accounts.Mutations do
  use Absinthe.Schema.Notation
  alias Api.{
    Accounts.Resolvers
  }


  input_object :update_user_attrs do
    field :username, :string
    field :email, :string
    field :password, :string
  end

  input_object :create_user_place_attrs do
    field :place_id, non_null(:integer)
    field :role_id, non_null(:integer)
    field :x, non_null(:float)
    field :y, non_null(:float)
  end

  input_object :update_user_places_attrs do
    field :place_id, non_null(:integer)
    field :x, non_null(:float)
    field :y, non_null(:float)
  end

  object :accounts_mutations do

    @desc "Create user place"
    field :create_user_place, type: :user_place do
      arg :user_place, :create_user_place_attrs

      middleware ApiWeb.Middleware.RequireAuthorized
      resolve &Resolvers.create_user_place/2
    end

    @desc "Delete user place"
    field :delete_user_place, type: :user_place do
      arg :place_id, non_null(:integer)

      middleware ApiWeb.Middleware.RequireAuthorized
      resolve &Resolvers.delete_user_place/2
    end

    @desc "Update user"
    field :update_user, type: :user do
      arg :id, :integer
      arg :user, :update_user_attrs

      middleware ApiWeb.Middleware.RequireAuthorized
      resolve &Resolvers.update/2
    end

    @desc "Update user places"
    field :update_user_places, type: list_of(:user_place) do
      arg :id, :integer
      arg :user_places, non_null(list_of(:update_user_places_attrs))

      middleware ApiWeb.Middleware.RequireAuthorized
      resolve &Resolvers.update_user_places/2
    end

  end
end
