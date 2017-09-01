ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Api.Repo, :manual)

defmodule Api.Helpers do
  def setup do
    {:ok, user} = Api.Accounts.create_user(%{email: "a@b.c", password: "some password"})
    {:ok, user2} = Api.Accounts.create_user(%{email: "w@x.c", password: "some password"})
    {:ok, role} = Api.Accounts.create_role(%{role_name: "guardian"})
    {:ok, place} = Api.Map.create_place(%{title: "home", latitude: 2, longitude: 40})
    {:ok, place2} = Api.Map.create_place(%{title: "home2", latitude: 2, longitude: 40})
    {:ok, userplace} = Api.Accounts.create_user_place(%{
      user_id: user.id,
      place_id: place.id,
      role_id: role.id
    })
    {:ok, useruser} = Api.Accounts.create_user_user(%{
      user_id: user.id,
      followee: user2.id
    })
    {:ok, user: user, user2: user2, place: place, place2: place2, role: role, userplace: userplace, useruser: useruser}
  end
end

