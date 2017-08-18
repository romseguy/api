defmodule Api.Map.Mutations do
  use Absinthe.Schema.Notation
  alias Api.{
    Map.Resolvers,
  }


  input_object :create_place_attrs do
    field :city, :string
    field :department, :string
    field :latitude, :float
    field :longitude, :float
    field :title, :string
  end

  input_object :update_place_attrs do
    field :city, :string
    field :department, :string
    field :latitude, :float
    field :longitude, :float
    field :title, :string
  end

  object :map_mutations do
    @desc "Create place"
    field :create_place, type: :place do
      arg :place, :create_place_attrs

      middleware ApiWeb.Middleware.RequireAuthorized
      resolve &Resolvers.create/2
    end

    @desc "Update place by id"
    field :update_place, type: :place do
      arg :id, non_null(:integer)
      arg :place, :update_place_attrs

      middleware ApiWeb.Middleware.RequireAuthorized
      resolve &Resolvers.update/2
    end
  end
end
