defmodule Api.Map.Queries do
  use Absinthe.Schema.Notation
  alias Api.Map.Resolvers


  object :map_queries do
    @doc"""
    Place
    """
    @desc "QUERY a place"
    field :place, type: :place do
      arg :id, :integer
      arg :title, :string

      resolve &Resolvers.place/2
    end
    @desc "QUERY all places"
    field :places, type: list_of(:place) do
      resolve &Resolvers.places/2
    end
    @doc"""
    UserPlace
    """
    @desc "QUERY the relationship between a place and current or given user"
    field :my_place, type: :user_place do
      arg :title, non_null(:string)
      arg :username, :string

      resolve &Resolvers.user_place/2
    end
    @doc"""
    [UserPlace]
    """
    @desc "QUERY my relationships with places"
    field :my_places, type: list_of(:user_place) do
      arg :username, :string

      resolve &Resolvers.user_places/2
    end
  end
end
