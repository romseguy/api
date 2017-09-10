defmodule Api.Map.Mutations do
  use Absinthe.Schema.Notation
  alias Api.Map.Resolvers
  alias ApiWeb.Middleware.RequireAuthorized


  object :map_mutations do
    @doc"""
    Place
    """
    @desc "CREATE a place"
    field :create_place, type: :place do
      arg :place, :create_place_attrs

      middleware RequireAuthorized
      resolve &Resolvers.create/2
    end
    @desc "UPDATE a place"
    field :update_place, type: :place do
      arg :id, non_null(:integer)
      arg :place, :update_place_attrs

      middleware RequireAuthorized
      resolve &Resolvers.update/2
    end
    @doc"""
    UserPlace
    """
    @desc "CREATE a relationship with a place"
    field :create_user_place, type: :user_place do
      arg :user_place, :create_user_place_attrs

      middleware RequireAuthorized
      resolve &Resolvers.create_user_place/2
    end
    @desc "UPDATE my relationship with a place"
    field :update_user_place, type: :user_place do
      arg :place, non_null(:update_place_attrs)
      arg :user_place, non_null(:update_user_places_attrs)

      middleware RequireAuthorized
      resolve &Resolvers.update_user_place/2
    end
    @desc "DELETE my relationship with a place"
    field :delete_user_place, type: :user_place do
      arg :place_id, non_null(:integer)

      middleware RequireAuthorized
      resolve &Resolvers.delete_user_place/2
    end
    @doc """
    [UserPlace]
    """
    @desc "UPDATE my relationships with places"
    field :update_user_places, type: list_of(:user_place) do
      arg :user_places, non_null(list_of(:update_user_places_attrs))

      middleware RequireAuthorized
      resolve &Resolvers.update_user_places/2
    end
  end
end
