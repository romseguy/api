defmodule Api.Map.Resolvers do
  import Logger


  @doc"""
  get all places
  """
  def places(_args, _info) do
    {:ok, Api.Map.list_places()}
  end

  @doc"""
  get all places for current user
  """
  def my_places(_args, %{context: %{current_user: current_user}}) do
    user_places = Api.Accounts.list_user_places(current_user)
    {:ok, Api.Repo.preload(user_places, [:user, :place, :role])}
  end
  def my_places(_args, _info) do
    {:ok, nil}
  end

  @doc"""
  get a place by attributes
  """
  def place(%{title: place_title}, _info) do
    {:ok, Api.Map.get_place(%{"title" => place_title})}
  end
  def place(_args, _info) do
    {:error, "place not found"}
  end

  @doc"""
  create place
  """
  def create(%{place: place_attrs}, %{context: %{current_user: %{id: current_user_id}}}) do
    {:ok, place} = Api.Map.create_place(place_attrs)
    Api.Accounts.create_user_place(%{
      "user_id": current_user_id,
      "place_id": place.id,
      "role_id": 1
    })
  end

  @doc"""
  update place if current user belongs to it and is a guardian
  """
  def update(%{id: place_id, place: place_attrs}, %{context: %{current_user: %{id: current_user_id}}}) do
    current_user_places = Api.Accounts.list_user_places(%{"user_id" => current_user_id})
    current_user_place = Enum.find(current_user_places, &(&1.place_id === place_id))

    cond do
      is_nil(current_user_place) -> {:error, "User does not belong to that place"}
      current_user_place.role_id !== 1 -> {:error, "User is not place's guardian"}
      true -> Api.Map.update_place(Api.Map.get_place!(place_id), place_attrs)
    end
  end

end
