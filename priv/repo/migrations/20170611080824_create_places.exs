defmodule Api.Repo.Migrations.CreateApi.Map.Schema.Place do
  use Ecto.Migration

  def change do
    create table(:places) do
      add :city, :string
      add :department, :string
      add :latitude, :float
      add :longitude, :float
      add :title, :string

      timestamps()
    end
    create index(:places, [:title], unique: true)
  end
end
