defmodule Api.Repo.Migrations.CreateUserplaces do
  use Ecto.Migration

  def change do
    create table(:user_places) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :place_id, references(:places, on_delete: :delete_all)
      add :role_id, references(:roles)
      add :x, :float
      add :y, :float

      timestamps()
    end
    create index(:user_places, [:user_id])
    create index(:user_places, [:place_id])
    create index(:user_places, [:role_id])
    create index(:user_places, [:user_id, :place_id, :role_id], unique: true)
  end
end
