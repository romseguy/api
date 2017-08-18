defmodule Api.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Helpers.Validation

  alias Api.Accounts.{
    User,
    UserPlace
  }
  alias Api.Map.Place


  @doc"""
  ecto schema/struct for the users table
  """
  schema "users" do
    #field :city, :string
    #field :department, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string
    many_to_many :places, Place, join_through: UserPlace

    timestamps()
  end


  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username])
    |> validate_required([:email])
  end

  def create_changeset(%User{} = user, attrs \\ %{}) do
    user
    |> update_changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash
  end

  def update_changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :username])
    |> validate_required([:email])
    |> validate_length(:username, min: 1, max: 40)
    |> validate_length(:email, min: 3)
    |> unique_constraint(:username, message: "Username already taken")
    |> validate_email_format(:email)
    |> unique_constraint(:email, message: "Email already taken")
    |> downcase_user_email
  end

  defp downcase_user_email(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{email: email}} ->
        put_change(changeset, :email, String.downcase(email))
      _ ->
        changeset
    end
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        changeset
        |> delete_change(:password)
        |> put_change(:password_hash, Comeonin.Bcrypt.hashpwsalt(password))

      %Ecto.Changeset{valid?: true} -> put_change(changeset, :password_hash, generate_token())

      _ -> changeset
    end
  end

  defp generate_token do
    50
    |> :crypto.strong_rand_bytes
    |> Base.url_encode64
    |> binary_part(0, 50)
  end

end
