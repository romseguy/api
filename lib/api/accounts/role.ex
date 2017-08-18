defmodule Api.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias Api.Accounts.Role


  @doc"""
  ecto schema/struct for the roles table
  """
  schema "roles" do
    field :role_name, :string

    timestamps()
  end

  def changeset(%Role{} = role, attrs) do
    role
    |> cast(attrs, [:role_name])
    |> validate_required([:role_name])
  end
end
