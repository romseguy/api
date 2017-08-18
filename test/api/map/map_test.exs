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
end
