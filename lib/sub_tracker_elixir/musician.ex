defmodule SubTrackerElixir.Musician do
  use Ecto.Schema

  schema "musicians" do
    field :name, :string
    field :phone_number, :string
    field :email_address, :string
    belongs_to :instrument, Instrument
  end
end
