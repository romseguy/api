defmodule Api.Map.Resolvers do
  @doc"""
  Place
  """
    @doc"""
    QUERY place by id
    """
    def place(%{id: place_id}, _info) do
      {:ok, Api.Map.get_place!(place_id)}
    end
    @doc"""
    QUERY place by title
    """
    def place(%{title: place_title}, _info) do
      {:ok, Api.Map.get_place!(%{title: place_title})}
    end
    @doc"""
    QUERY place without matching argument
    """
    def place(_args, _info) do
      {:error, "place not found"}
    end
    @doc"""
    QUERY places
    """
    def places(_args, _info) do
      {:ok, Api.Map.list_places()}
    end
    @doc"""
    CREATE place
    """
    def create(%{place: place_attrs}, %{context: %{current_user: %{id: current_user_id}}}) do
      case Api.Map.create_place(place_attrs) do
        {:ok, place} ->
          Api.Map.create_user_place(%{
            "user_id": current_user_id,
            "place_id": place.id,
            "role_id": 1
          })
          {:ok, place}
        {:error, changeset} -> {:error, changeset}
      end
    end
    @doc"""
    UPDATE place if current user belongs to it and is a guardian
    """
    def update(%{id: place_id, place: place_attrs}, %{context: %{current_user: %{id: current_user_id}}}) do
      current_user_places = Api.Map.list_user_places(current_user_id)
      current_user_place = Enum.find(current_user_places, &(&1.place_id === place_id))

      cond do
        is_nil(current_user_place) -> {:error, "user does not belong to that place"}
        current_user_place.role_id !== 1 -> {:error, "user is not place's guardian"}
        true -> Api.Map.update_place(Api.Map.get_place!(place_id), place_attrs)
      end
    end
    @doc"""
    DELETE place if current user is its creator
    """
    def delete(%{id: place_id}, %{context: %{current_user: %{id: current_user_id}}}) do
      # todo: checks
      place = Api.Map.get_place!(place_id)
      Api.Map.delete_place(place)
    end
  @doc"""
  UserPlace
  """
    @doc"""
    QUERY user_place by place title for current_user
    """
    def user_place(%{title: place_title}, %{context: %{current_user: current_user}}) do
      place = Api.Map.get_place!(%{title: place_title})
      case Api.Map.get_user_place(current_user, place) do
        nil -> {:ok, nil}
        user_place -> {:ok, Api.Repo.preload(user_place, [:user, :place, :role])}
      end
    end
    @doc"""
    CREATE user_place for current_user
    """
    def create_user_place(%{user_place: user_place}, %{context: %{current_user: %{id: current_user_id}}}) do
      Api.Map.create_user_place(Map.put_new(user_place, :user_id, current_user_id))
    end
    @doc"""
    UPDATE user_place by place_id for current_user
    """
    def update_user_place(%{user_places: user_places_attrs}, %{context: %{current_user: %{id: current_user_id}}}) do
      user_places = user_places_attrs
      |> Enum.filter(&(Map.has_key?(&1, :place_id)))
      |> Enum.map(fn %{place_id: place_id, x: x, y: y} ->
        case Api.Map.get_user_place(current_user_id, place_id) do
          nil -> nil
          user_place ->
            Api.Map.update_user_place(user_place, %{x: x, y: y})
            {:ok, user_place}
        end
      end)

      {:ok, user_places}
    end
    @doc"""
    DELETE user_place by place_id for current_user
    """
    def delete_user_place(%{place_id: place_id}, %{context: %{current_user: current_user}}) do
      place = Api.Map.get_place!(place_id)
      user_place = Api.Map.get_user_place(current_user, place)
      Api.Map.delete_user_place(user_place)
      {:ok, user_place}
    end
  @doc """
  [UserPlace]
  """
    @doc"""
    QUERY user_places by username
    """
    def user_places(%{username: username}, %{context: %{current_user: current_user}}) do
      user = Api.Accounts.get_user(%{username: username})
      user_places = Api.Map.list_user_places(user)
      {:ok, Api.Repo.preload(user_places, [:user, :place, :role])}
    end
    @doc"""
    QUERY user_places for current_user
    """
    def user_places(_args, %{context: %{current_user: current_user}}) do
      user_places = Api.Map.list_user_places(current_user)
      {:ok, Api.Repo.preload(user_places, [:user, :place, :role])}
    end
    @doc"""
    QUERY user_places without current_user
    """
    def user_places(_args, _info) do
      {:ok, nil}
    end
    @doc"""
    UPDATE user_places for current_user
    """
    def update_user_places(%{user_places: user_places_attrs}, %{context: %{current_user: %{id: current_user_id}}}) do
      user_places = user_places_attrs
      |> Enum.filter(&(Map.has_key?(&1, :place_id)))
      |> Enum.map(fn %{place_id: place_id, x: x, y: y} ->
        {:ok, user_place} = Api.Map.get_user_place(current_user_id, place_id)
        |> Api.Map.update_user_place(%{x: x, y: y})
        user_place
      end)

      {:ok, user_places}
    end
end
