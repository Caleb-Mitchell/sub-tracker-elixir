defmodule SubTrackerElixir.Musician do
  use Ecto.Schema

  import Ecto.Query
  import Ecto.Changeset

  schema "musicians" do
    field :name, :string
    field :phone_number, :string
    field :email_address, :string
    belongs_to :instrument, SubTrackerElixir.Instrument
  end

  @items_per_page 5

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

  def load_musician(musician_id) do
    SubTrackerElixir.Repo.get!(SubTrackerElixir.Musician, musician_id)
  end

  def musicians_page(page_num, instrument_id) do
    query =
      from m in "musicians",
        where: m.instrument_id == ^instrument_id,
        order_by: m.name,
        select: {m.name, m.id, m.phone_number, m.email_address},
        limit: @items_per_page,
        offset: @items_per_page * (^page_num - 1)

    SubTrackerElixir.Repo.all(query)
    |> Enum.map(fn {name, id, phone_number, email_address} ->
      %{name: name, id: id, phone_number: phone_number, email_address: email_address}
    end)
  end

  def add_musician(name, phone, email, instrument_id) do
    musician = %SubTrackerElixir.Musician{
      name: name,
      phone_number: phone,
      email_address: email,
      instrument_id: instrument_id
    }

    IO.inspect(musician)
    SubTrackerElixir.Repo.insert(musician)
  end

  def delete_musician(musician_id) do
    musician = SubTrackerElixir.Repo.get!(SubTrackerElixir.Musician, musician_id)
    SubTrackerElixir.Repo.delete(musician)
  end

  def update_musician(musician_id, name, phone, email, instrument_id) do
    musician = SubTrackerElixir.Repo.get!(SubTrackerElixir.Musician, musician_id)

    changeset =
      change(musician, %{
        name: name,
        phone_number: phone,
        email_address: email,
        instrument_id: instrument_id
      })

    SubTrackerElixir.Repo.update(changeset)
  end
end
