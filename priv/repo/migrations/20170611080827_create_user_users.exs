defmodule Api.Repo.Migrations.CreateFollowings do
  use Ecto.Migration

  def change do
    create table(:user_users) do
      add :user_id, references(:users, on_delete: :nothing)
      add :followee_id, references(:users, on_delete: :nothing)
      add :x, :float
      add :y, :float

      timestamps()
    end
    create index(:user_users, [:user_id])
    create index(:user_users, [:followee_id])
    create index(:user_users, [:user_id, :followee_id], unique: true)
  end
end
