defmodule Api.GraphQLTest do
  use Api.DataCase

  alias Api.{ Accounts }


  setup do
    {:ok, user} = Accounts.create_user(%{email: "a@b.c", password: "some password"})
    {:ok, role} = Accounts.create_role(%{role_name: "guardian"})
    {:ok, place} = Api.Map.create_place(%{ title: "home", latitude: 1, longitude: 2 })
    {:ok, userplace} = Accounts.create_user_place(%{user_id: user.id, place_id: place.id, role_id: role.id})
    {:ok, user: user, place: place, role: role, userplace: userplace}
  end
end
