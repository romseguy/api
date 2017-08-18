ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Api.Repo, :manual)

defmodule Api.Helpers do
  def setup do
    {:ok, user} = Api.Accounts.create_user(%{email: "a@b.c", password: "some password"})
    {:ok, role} = Api.Accounts.create_role(%{role_name: "guardian"})
    {:ok, place} = Api.Map.create_place(%{title: "home", latitude: 2, longitude: 40})
    {:ok, place2} = Api.Map.create_place(%{title: "home2", latitude: 2, longitude: 40})
    {:ok, userplace} = Api.Accounts.create_user_place(%{
      user_id: user.id,
      place_id: place.id,
      role_id: role.id
    })
    {:ok, user: user, place: place, place2: place2, role: role, userplace: userplace}
  end
end

