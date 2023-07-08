defmodule SubTrackerElixir.Instrument do
  use Ecto.Schema

  schema "instruments" do
    field :name, :string
    has_many :musicians, Musician
  end
end
