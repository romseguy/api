# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Repo.insert!(%Api.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Api.Repo
alias Api.Accounts.{
  Role,
  User
}
alias Api.Map.{
  Place,
  UserPlace
}

Api.Accounts.create_user(%{
  :email => "le@parede.com",
  :password => "foobar",
  :username => "leparede",
})

Repo.insert!(%Place{
  :city => "Bagnères-de-Bigorre",
  :department => "Hautes-Pyrénées",
  :latitude => 43.0682282223,
  :longitude => 0.1339986988,
  :title => "Le Parédé",
})
Api.Repo.insert!(%Place{
  :city => "Uzès",
  :department => "Gard",
  :latitude => 44.2167,
  :longitude => 4.2167,
  :title => "foo",
})

Repo.insert!(%Role{
  :role_name => "Guardian"
})
Repo.insert!(%Role{
  :role_name => "Follower"
})

Api.Map.create_user_place(%{
  user_id: 1,
  place_id: 1,
  role_id: 1
})
Api.Map.create_user_place(%{
  user_id: 1,
  place_id: 2,
  role_id: 2
})

