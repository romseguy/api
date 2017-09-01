defmodule Api.Accounts.UserUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias Api.Accounts.{
    User,
    UserUser
  }


  @doc"""
  ecto schema/struct for the user_users table
  representing the one-to-many relation between a user and the people he/she follows
  """
  schema "user_users" do
    belongs_to :user, User
    belongs_to :followee, User
    field :x, :float
    field :y, :float

    timestamps()
  end

  def changeset(%UserUser{} = user_user, attrs) do
    user_user
    |> cast(attrs, [:user_id, :x, :y])
    |> validate_required([:user_id])
  end
end
