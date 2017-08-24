defmodule Api.Map.Queries do
  use Absinthe.Schema.Notation
  alias Api.{
    Map.Resolvers,
  }

  object :map_queries do

    @desc "Get my places"
    field :my_places, type: list_of(:user_place) do
      arg :username, :string

      resolve &Resolvers.my_places/2
    end

    @desc "Get place by attribute"
    field :place, type: :place do
      arg :title, :string

      resolve &Resolvers.place/2
    end

    @desc "Get all places"
    field :places, type: list_of(:place) do
      resolve &Resolvers.places/2
    end

  end
end
