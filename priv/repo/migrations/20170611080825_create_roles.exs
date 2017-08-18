defmodule Api.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :role_name, :string

      timestamps()
    end
  end
end
