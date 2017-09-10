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
    @desc "QUERY my relationships with places"
    field :my_places, type: list_of(:user_place) do
      arg :username, :string

      resolve &Resolvers.my_user_places/2
    end


  end
end
