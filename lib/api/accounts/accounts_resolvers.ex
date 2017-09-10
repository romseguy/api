defmodule Api.Accounts.Resolvers do
  import Logger

  @doc"""
  User
  """
    @doc"""
    QUERY current_user
    """
    def current(_args, %{context: %{current_user: %{id: current_user_id}}}) do
      {:ok, Api.Accounts.get_user!(current_user_id)}
    end
    @doc"""
    QUERY current_user without current_user
    """
    def current(_args, _info) do
      {:ok, nil}
    end
    @doc"""
    QUERY user by user_id
    """
    def user(%{id: user_id}, _info) do
      {:ok, Api.Accounts.get_user!(user_id)}
    end
    @doc"""
    QUERY user by username
    """
    def user(%{username: username}, _info) do
      {:ok, Api.Accounts.get_user(%{username: username})}
    end
    @doc"""
    QUERY users
    """
    def users(_args, _info) do
      {:ok, Api.Accounts.list_users()}
    end
    @doc"""
    UPDATE current user
    """
    def update(%{user: user_attrs}, %{context: %{current_user: %{id: current_user_id}}}) do
      Api.Accounts.get_user!(current_user_id)
      |> Api.Accounts.update_user(user_attrs)
    end
  @doc"""
  UserUser
  """
    @doc"""
    QUERY user_users (relationships) for current_user
    """
    def my_user_users(_args, %{context: %{current_user: %{id: current_user_id}}}) do
      {:ok, Api.Accounts.list_user_users(current_user_id)}
    end
    @doc"""
    CREATE user_user (relationship) for current_user
    """
    def create_user_user(%{followee: followee}, %{context: %{current_user: %{id: current_user_id}}}) do
      Api.Accounts.create_user_user(Map.put_new(followee, :user_id, current_user_id))
    end
    @doc"""
    CREATE user_user for user_id
    """
    def create_user_user(%{id: user_id, user: followee}, %{context: %{current_user: %{id: current_user_id}}}) do
      Api.Accounts.create_user_user(Map.put_new(followee, :user_id, user_id))
    end
end

