defmodule Api.Accounts.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Api.Repo

  @email_regexp ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/

  def parse_and_validate_is_email(email) do
    case Regex.match?(@email_regexp, email) do
      false -> :error
      true -> {:ok, email}
    end
  end

  scalar :email do
    name "Email"
    description "User's Email"
    serialize fn(x) -> x end
    parse &parse_and_validate_is_email(&1.value)
  end

  object :role do
    field :id, :integer
    field :role_name, :string
    #default resolver looks like this:
    #do
    #  resolve fn role, _ , _ ->
    #    {:ok, Map.get(role, :role_name)}
    #  end
    #end
  end

  @desc "user"
  object :user do
    field :id, :integer
    field :username, :string
    field :email, :string
    field :password_hash, :string
    field :inserted_at, :string
    field :places, list_of(:place), resolve: assoc(:places)
  end

  input_object :update_user_attrs do
    field :username, :string
    field :email, :string
    field :password, :string
  end

  @desc "user_place"
  object :user_place do
    field :id, :integer
    field :user, :user
    field :place, :place
    field :role, :role
    field :x, :string
    field :y, :string
    field :inserted_at, :string
  end

  input_object :create_user_place_attrs do
    field :place_id, non_null(:integer)
    field :role_id, non_null(:integer)
    field :x, :float
    field :y, :float
  end

  input_object :update_user_places_attrs do
    field :place_id, non_null(:integer)
    field :x, :float
    field :y, :float
  end

  @desc "user_user"
  object :user_user do
    field :id, :integer
    field :followee, :integer
    field :x, :string
    field :y, :string
    field :inserted_at, :string
  end

  input_object :create_user_user_attrs do
    field :followee_id, non_null(:integer)
    field :x, :float
    field :y, :float
  end
end
