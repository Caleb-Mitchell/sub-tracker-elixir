defmodule SubTrackerElixir.Musician do
  use Ecto.Schema

  import Ecto.Query
  # import Ecto.Changeset

  schema "musicians" do
    field :name, :string
    field :phone_number, :string
    field :email_address, :string
    belongs_to :instrument, SubTrackerElixir.Instrument
  end

  def list_musicians(instrument_id) do
    query =
      from m in "musicians",
        where: m.instrument_id == ^instrument_id,
        order_by: m.name,
        select: {m.name, m.id, m.phone_number, m.email_address}

    SubTrackerElixir.Repo.all(query)
    |> Enum.map(fn {name, id, phone_number, email_address} ->
      %{name: name, id: id, phone_number: phone_number, email_address: email_address}
    end)
  end
end
