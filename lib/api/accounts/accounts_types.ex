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

  object :user do
    field :id, :integer
    field :username, :string
    field :email, :string
    field :password_hash, :string
    field :inserted_at, :string
    field :places, list_of(:place), resolve: assoc(:places)
  end

  object :user_place do
    field :id, :integer
    field :user, :user
    field :place, :place
    field :role, :role
    field :x, :string
    field :y, :string
    field :inserted_at, :string
  end

  object :user_user do
    field :id, :integer
    field :followee, :integer
    field :x, :string
    field :y, :string
    field :inserted_at, :string
  end
end
