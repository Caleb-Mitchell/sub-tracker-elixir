defmodule SubTrackerElixir.Repo.Migrations.CreateMusicians do
  use Ecto.Migration

  def change do
    create table(:musicians) do
      add :name, :string, null: false
      add :phone_number, :string
      add :email_address, :string
      add :instrument_id, references(:instruments, on_delete: :delete_all), null: false
    end
    create unique_index(:musicians, [:name])
  end
end
