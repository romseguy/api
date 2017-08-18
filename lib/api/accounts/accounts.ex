defmodule Api.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Accounts.{
    User,
    UserPlace,
    Role
  }

  alias Api.Map.{
    Place
  }

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

      iex> get_user(%{"email" => "a@b.c"})
      nil

  """
  def get_user!(id), do: Repo.get!(User, id)
  def get_user(%{"email" => email}) do
    Repo.get_by(User, email: String.downcase(email))
  end
  def get_user(%{"username" => username}) do
    Repo.get_by(User, username: String.downcase(username))
  end


  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Returns the list of user_places.

  ## Examples

      iex> list_user_places()
      [%UserPlace{}, ...]

  """
  def list_user_places do
    Repo.all(UserPlace)
  end
  def list_user_places(user_id) when is_integer(user_id) do
    UserPlace
    |> where(user_id: ^user_id)
    |> Repo.all
  end
  def list_user_places(%User{} = user) do
    list_user_places(user.id)
  end
  def list_user_places(%Place{} = place) do
    UserPlace
    |> where(place_id: ^place.id)
    |> Repo.all
  end

  @doc """
  Gets a single user_place.

  Raises `Ecto.NoResultsError` if the User place does not exist.

  ## Examples

      iex> get_user_place!(123)
      %UserPlace{}

      iex> get_user_place!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_place!(id), do: Repo.get!(UserPlace, id)
  def get_user_place!(user_id, place_id) when is_integer(user_id) and is_integer(place_id) do
    UserPlace
    |> where(place_id: ^place_id)
    |> where(user_id: ^user_id)
    |> Repo.one!
  end
  def get_user_place!(%User{} = user, %Place{} = place) do
    get_user_place!(user.id, place.id)
  end

  @doc """
  Creates a user_place.

  ## Examples

      iex> create_user_place(%{field: value})
      {:ok, %UserPlace{}}

      iex> create_user_place(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_place(attrs \\ %{}) do
    %UserPlace{}
    |> UserPlace.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_place.

  ## Examples

      iex> update_user_place(user_place, %{field: new_value})
      {:ok, %UserPlace{}}

      iex> update_user_place(user_place, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_place(%UserPlace{} = user_place, attrs) do
    user_place
    |> UserPlace.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserPlace.

  ## Examples

      iex> delete_user_place(user_place)
      {:ok, %UserPlace{}}

      iex> delete_user_place(user_place)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_place(%UserPlace{} = user_place) do
    Repo.delete(user_place)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_place changes.

  ## Examples

      iex> change_user_place(user_place)
      %Ecto.Changeset{source: %UserPlace{}}

  """
  def change_user_place(%UserPlace{} = user_place) do
    UserPlace.changeset(user_place, %{})
  end

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Role{}, ...]

  """
  def list_roles do
    Repo.all(Role)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(role, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Role.

  ## Examples

      iex> delete_role(role)
      {:ok, %Role{}}

      iex> delete_role(role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role changes.

  ## Examples

      iex> change_role(role)
      %Ecto.Changeset{source: %Role{}}

  """
  def change_role(%Role{} = role) do
    Role.changeset(role, %{})
  end
end
