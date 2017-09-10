defmodule Api.Map.Place do
  use Ecto.Schema
  import Ecto.Changeset

  alias Api.Accounts.{
    User
  }
  alias Api.Map.{
    Place,
    UserPlace
  }


  @doc"""
  ecto schema/struct for the places table
  """
  schema "places" do
    field :city, :string
    field :department, :string
    field :latitude, :float
    field :longitude, :float
    field :title, :string
    many_to_many :users, User, join_through: UserPlace

    timestamps()
  end

  def changeset(%Place{} = place, attrs) do
    place
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end

  def create_changeset(%Place{} = place, attrs \\ %{}) do
    place
    |> cast(attrs, [:city, :department, :latitude, :longitude, :title])
    |> validate_required([:city, :department, :latitude, :longitude, :title])
    |> unique_constraint(:title, message: "Place name already taken")
  end

  def update_changeset(%Place{} = place, attrs \\ %{}) do
    place
    |> cast(attrs, [:city, :department, :latitude, :longitude, :title])
    |> validate_required([:title])
    |> unique_constraint(:title, message: "Place name already taken")
  end
end
