defmodule Api.Map.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Api.Repo # provides assoc helper function


  object :place do
    field :id, :integer
    field :city, :string
    field :department, :string
    field :latitude, :float
    field :longitude, :float
    field :title, :string
    field :users, list_of(:user), resolve: assoc(:users)
  end
end
