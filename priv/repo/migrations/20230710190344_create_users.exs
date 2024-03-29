defmodule SubTrackerElixir.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :password, :string, null: false
    end
    create unique_index(:users, [:name])
    create unique_index(:users, [:password])
  end
end
