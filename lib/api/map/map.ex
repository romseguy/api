defmodule Api.Map do
  @moduledoc """
  The boundary for the Map system.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Accounts.{
     User
  }
  alias Api.Map.{
    Place,
    UserPlace
  }

  @doc """
  Returns the list of places.

  ## Examples

      iex> list_places()
      [%Place{}, ...]

  """
  def list_places do
    Repo.all(Place)
  end
  def list_places(%User{} = user) do
    Repo.all(Ecto.assoc(user, :places))
  end

  @doc """
  Gets a single place.

  Raises `Ecto.NoResultsError` if the Place does not exist.

  ## Examples

      iex> get_place!(123)
      %Place{}

      iex> get_place!(456)
      ** (Ecto.NoResultsError)

  """
  def get_place!(%{title: place_title}) do
    Repo.get_by(Place, title: place_title)
  end
  def get_place!(id), do: Repo.get!(Place, id)

  @doc """
  Creates a place.

  ## Examples

      iex> create_place(%{field: value})
      {:ok, %Place{}}

      iex> create_place(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_place(attrs \\ %{}) do
    %Place{}
    |> Place.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a place.

  ## Examples

      iex> update_place(place, %{field: new_value})
      {:ok, %Place{}}

      iex> update_place(place, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_place(%Place{} = place, attrs) do
    place
    |> Place.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Place.

  ## Examples

      iex> delete_place(place)
      {:ok, %Place{}}

      iex> delete_place(place)
      {:error, %Ecto.Changeset{}}

  """
  def delete_place(%Place{} = place) do
    Repo.delete(place)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking place changes.

  ## Examples

      iex> change_place(place)
      %Ecto.Changeset{source: %Place{}}

  """
  def change_place(%Place{} = place) do
    Place.changeset(place, %{})
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
  def get_user_place(%User{} = user, %Place{} = place) do
    get_user_place(user.id, place.id)
  end
  def get_user_place(user_id, place_id) when is_integer(user_id) and is_integer(place_id) do
    UserPlace
    |> where(place_id: ^place_id)
    |> where(user_id: ^user_id)
    |> Repo.one
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

end
