defmodule SubTrackerElixir.Repo.Migrations.CreateInstruments do
  use Ecto.Migration

  def change do
    create table(:instruments) do
      add :name, :string, null: false
    end
    create unique_index(:instruments, [:name])
  end
end
