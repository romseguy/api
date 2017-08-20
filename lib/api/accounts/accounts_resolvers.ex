defmodule Api.Accounts.Resolvers do
  import Logger


  def all(_args, _info) do
    {:ok, Api.Accounts.list_users()}
  end

  @doc"""
  get all places for current user
  """
  def my_users(_args, %{context: %{current_user: current_user}}) do
    user_users = Api.Accounts.list_user_users(current_user)
    {:ok, Api.Repo.preload(user_users, [:user, :place, :role])}
  end
  def my_users(_args, _info) do
    {:ok, nil}
  end

  def current(_args, %{context: %{current_user: %{id: current_user_id}}}) do
    {:ok, Api.Accounts.get_user!(current_user_id)}
  end
  def current(_args, _context) do
    {:ok, nil}
  end

  def find(%{id: user_id}, _info) do
    {:ok, Api.Accounts.get_user!(user_id)}
  end

  def update(%{id: user_id, user: user_attrs}, %{context: %{current_user: %{id: current_user_id}}}) do
    Api.Accounts.get_user!(user_id)
    |> Api.Accounts.update_user(user_attrs)
  end
  def update(%{user: user_attrs}, %{context: %{current_user: %{id: current_user_id}}}) do
    Api.Accounts.get_user!(current_user_id)
    |> Api.Accounts.update_user(user_attrs)
  end

  def create_user_place(%{user_place: user_place}, %{context: %{current_user: %{id: current_user_id}}}) do
    Api.Accounts.create_user_place(Map.put_new(user_place, :user_id, current_user_id))
  end

  def update_user_places(%{user_places: user_places_attrs}, %{context: %{current_user: %{id: current_user_id}}}) do
    user_places = user_places_attrs
    |> Enum.filter(&(Map.has_key?(&1, :place_id)))
    |> Enum.map(fn %{place_id: place_id, x: x, y: y} ->
      {:ok, user_place} = Api.Accounts.get_user_place!(current_user_id, place_id)
      |> Api.Accounts.update_user_place(%{x: x, y: y})
      user_place
    end)

    {:ok, user_places}
  end
  #todo: def update_user_places(%{id: user_id,user_places: user_places_attrs}, _info) do

  def delete_user_place(%{place_id: place_id}, %{context: %{current_user: current_user}}) do
    place = Api.Map.get_place!(place_id)
    user_place = Api.Accounts.get_user_place!(current_user, place)
    Logger.debug(inspect(user_place))
    Api.Accounts.delete_user_place(user_place)
    {:ok, user_place}
  end
end
