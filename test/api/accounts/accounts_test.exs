defmodule Api.Accounts.Test do
  use Api.DataCase

  alias Api.Accounts


  describe "users" do
    alias Api.Accounts.User

    @valid_password "some password"
    @valid_attrs %{email: "a@b.c"}
    @update_attrs %{email: "b@c.d"}
    @invalid_attrs %{email: nil, name: nil}

    setup do
      Api.Helpers.setup
    end

    test "list_users/0 returns all users", fixture do
      user = fixture.user
      assert Api.Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id", fixture do
      user = fixture.user
      assert Api.Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Api.Accounts.create_user(Map.put_new(@update_attrs, :password, @valid_password))
      assert user.email == Map.get(@update_attrs, :email)
    end

    test "create_user/1 with email already taken returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Api.Accounts.create_user(Map.put_new(@valid_attrs, :password, @valid_password))
      Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
        assert msg == "Email already taken"
      end)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {
      :error,
       %Ecto.Changeset{}
       } = Api.Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user", fixture do
      user = fixture.user
      assert {:ok, user} = Api.Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == Map.get(@update_attrs, :email)
    end

    test "update_user/2 with invalid data returns error changeset", fixture do
      user = fixture.user
      assert {:error, %Ecto.Changeset{}} = Api.Accounts.update_user(user, @invalid_attrs)
      assert user == Api.Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user", fixture do
      user = fixture.user
      assert {:ok, %User{}} = Api.Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Api.Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset", fixture do
      user = fixture.user
      assert %Ecto.Changeset{} = Api.Accounts.change_user(user)
    end
  end

  describe "user_places" do
    alias Api.Accounts.UserPlace

    @invalid_attrs %{user_id: nil, place_id: nil}

    setup do
      Api.Helpers.setup
    end

    test "list_user_places/0 returns all user_places", fixture do
      assert Api.Accounts.list_user_places() == [fixture.userplace]
    end

    test "get_user_place!/1 returns the user_place with given id", fixture do
      assert Api.Accounts.get_user_place!(fixture.userplace.id) == fixture.userplace
    end

    test "create_user_place/1 with valid data creates a user_place", fixture do
      assert {:ok, %UserPlace{} = user_place} = Api.Accounts.create_user_place(%{user_id: fixture.user.id, place_id: fixture.place2.id, role_id: fixture.role.id})
    end

    test "create_user_place/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.Accounts.create_user_place(@invalid_attrs)
    end

    test "update_user_place/2 with valid data updates the user_place", fixture do
      assert {:ok, user_place} = Api.Accounts.update_user_place(fixture.userplace, %{place_id: fixture.place2.id})
      assert %UserPlace{} = user_place
    end

    test "update_user_place/2 with invalid data returns error changeset", fixture do
      assert {:error, %Ecto.Changeset{}} = Api.Accounts.update_user_place(fixture.userplace, @invalid_attrs)
      assert fixture.userplace == Api.Accounts.get_user_place!(fixture.userplace.id)
    end

    test "delete_user_place/1 deletes the user_place", fixture do
      assert {:ok, %UserPlace{}} = Api.Accounts.delete_user_place(fixture.userplace)
      assert_raise Ecto.NoResultsError, fn -> Api.Accounts.get_user_place!(fixture.userplace.id) end
    end

    test "change_user_place/1 returns a user_place changeset", fixture do
      assert %Ecto.Changeset{} = Api.Accounts.change_user_place(fixture.userplace)
    end
  end

  describe "roles" do
    alias Api.Accounts.Role

    @valid_attrs %{role_name: "some role_name"}
    @update_attrs %{role_name: "some updated role_name"}
    @invalid_attrs %{role_name: nil}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Api.Accounts.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Api.Accounts.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Api.Accounts.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Api.Accounts.create_role(@valid_attrs)
      assert role.role_name == "some role_name"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.Accounts.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, role} = Api.Accounts.update_role(role, @update_attrs)
      assert %Role{} = role
      assert role.role_name == "some updated role_name"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.Accounts.update_role(role, @invalid_attrs)
      assert role == Api.Accounts.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Api.Accounts.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Api.Accounts.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Api.Accounts.change_role(role)
    end
  end
end
