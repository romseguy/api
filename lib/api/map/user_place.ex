defmodule Api.Map.UserPlace do
  use Ecto.Schema
  import Ecto.Changeset
  alias Api.Accounts.{
    User,
    Role
  }
  alias Api.Map.{
    Place,
    UserPlace
  }


  @doc"""
  ecto schema/struct for the user_places table
  representing the many-to-many relation between users, places, and roles
  """
  schema "user_places" do
    belongs_to :user, User
    belongs_to :place, Place
    belongs_to :role, Role
    field :x, :float
    field :y, :float

    timestamps()
  end

  def changeset(%UserPlace{} = user_place, attrs) do
    user_place
    |> cast(attrs, [:user_id, :place_id, :role_id, :x, :y])
    |> validate_required([:user_id, :place_id, :role_id])
  end
end
