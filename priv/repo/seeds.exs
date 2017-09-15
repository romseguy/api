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
  :email => "alex@gmail.com",
  :password => "foobar",
  :username => "alex",
})

Api.Accounts.create_user(%{
  :email => "claire@gmail.com",
  :password => "foobar",
  :username => "claire",
})

Api.Accounts.create_user(%{
  :email => "gael@gmail.com",
  :password => "foobar",
  :username => "gael",
})

Api.Accounts.create_user(%{
  :email => "rom.seguy@gmail.com",
  :password => "foobar",
  :username => "romain",
})

# Api.Map.create_place(%{ :city => "Bagnères-de-Bigorre", :department => "Hautes-Pyrénées", :latitude => 43.0682282223, :longitude => 0.1339986988, :title => "Le Parédé"})
# Api.Map.create_place(%{ :city => "Uzès", :department => "Gard", :latitude => 44.2167, :longitude => 4.2167, :title => "Chez Romain"})

Api.Accounts.create_role(%{
  :role_name => "Guardian"
})
Api.Accounts.create_role(%{
  :role_name => "Follower"
})

# Api.Map.create_user_place(%{ user_id: 1, place_id: 1, role_id: 1 })
# Api.Map.create_user_place(%{ user_id: 1, place_id: 2, role_id: 2 })

