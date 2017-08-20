defmodule Api.Map.Queries do
  use Absinthe.Schema.Notation
  alias Api.{
    Map.Resolvers,
  }

  object :map_queries do
    @desc "Get all places"
    field :places, type: list_of(:place) do
      resolve &Resolvers.places/2
    end

    @desc "Get place by title"
    field :place, type: :place do
      arg :title, :string

      resolve &Resolvers.place/2
    end

    @desc "Get my places"
    field :my_places, type: list_of(:user_place) do
      resolve &Resolvers.my_places/2
    end
  end
end
