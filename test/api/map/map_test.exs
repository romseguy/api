defmodule Api.MapTest do
  use Api.DataCase

  alias Api.Map

  describe "places" do
    alias Api.Map.Place

    @valid_attrs %{title: "some title", longitude: 4, latitude: 5}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def place_fixture(attrs \\ %{}) do
      {:ok, place} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Map.create_place()

      place
    end

    test "list_places/0 returns all places" do
      place = place_fixture()
      assert Map.list_places() == [place]
    end

    test "get_place!/1 returns the place with given id" do
      place = place_fixture()
      assert Map.get_place!(place.id) == place
    end

    test "create_place/1 with valid data creates a place" do
      assert {:ok, %Place{} = place} = Map.create_place(@valid_attrs)
      assert place.title == "some title"
    end

    test "create_place/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Map.create_place(@invalid_attrs)
    end

    test "update_place/2 with valid data updates the place" do
      place = place_fixture()
      assert {:ok, place} = Map.update_place(place, @update_attrs)
      assert %Place{} = place
      assert place.title == "some updated title"
    end

    test "update_place/2 with invalid data returns error changeset" do
      place = place_fixture()
      assert {:error, %Ecto.Changeset{}} = Map.update_place(place, @invalid_attrs)
      assert place == Map.get_place!(place.id)
    end

    test "delete_place/1 deletes the place" do
      place = place_fixture()
      assert {:ok, %Place{}} = Map.delete_place(place)
      assert_raise Ecto.NoResultsError, fn -> Map.get_place!(place.id) end
    end

    test "change_place/1 returns a place changeset" do
      place = place_fixture()
      assert %Ecto.Changeset{} = Map.change_place(place)
    end
  end

  describe "user_places" do
    alias Api.Map.UserPlace

    @invalid_attrs %{user_id: nil, place_id: nil}

    setup do
      Api.Helpers.setup
    end

    test "list_user_places/0 returns all user_places", fixture do
      assert Api.Map.list_user_places() == [fixture.userplace]
    end

    test "get_user_place!/1 returns the user_place with given id", fixture do
      assert Api.Map.get_user_place!(fixture.userplace.id) == fixture.userplace
    end

    test "create_user_place/1 with valid data creates a user_place", fixture do
      assert {:ok, %UserPlace{} = user_place} = Api.Map.create_user_place(%{user_id: fixture.user.id, place_id: fixture.place2.id, role_id: fixture.role.id})
    end

    test "create_user_place/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.Map.create_user_place(@invalid_attrs)
    end

    test "update_user_place/2 with valid data updates the user_place", fixture do
      assert {:ok, user_place} = Api.Map.update_user_place(fixture.userplace, %{place_id: fixture.place2.id})
      assert %UserPlace{} = user_place
    end

    test "update_user_place/2 with invalid data returns error changeset", fixture do
      assert {:error, %Ecto.Changeset{}} = Api.Map.update_user_place(fixture.userplace, @invalid_attrs)
      assert fixture.userplace == Api.Map.get_user_place!(fixture.userplace.id)
    end

    test "delete_user_place/1 deletes the user_place", fixture do
      assert {:ok, %UserPlace{}} = Api.Map.delete_user_place(fixture.userplace)
      assert_raise Ecto.NoResultsError, fn -> Api.Map.get_user_place!(fixture.userplace.id) end
    end

    test "change_user_place/1 returns a user_place changeset", fixture do
      assert %Ecto.Changeset{} = Api.Accounts.change_user_place(fixture.userplace)
    end
  end
end
