defmodule SubTrackerElixir.Instrument do
  use Ecto.Schema
  import Ecto.Changeset

  import Ecto.Query

  schema "instruments" do
    field :name, :string
    has_many :musician, SubTrackerElixir.Musician
  end

  @num_pages_visible 5
  @items_per_page 5

  def list_instruments do
    query =
      from i in "instruments",
        order_by: i.name,
        select: {i.name, i.id}

    SubTrackerElixir.Repo.all(query)
    |> Enum.map(fn {name, id} -> %{name: name, id: id} end)
  end

  def instruments_page(page_num) do
    query =
      from i in "instruments",
        order_by: i.name,
        select: {i.name, i.id},
        limit: @items_per_page,
        offset: @items_per_page * (^page_num - 1)

    SubTrackerElixir.Repo.all(query)
    |> Enum.map(fn {name, id} -> %{name: name, id: id} end)
  end

  def load_instrument(instrument_id) do
    SubTrackerElixir.Repo.get!(SubTrackerElixir.Instrument, instrument_id)
  end

  def find_instrument_id(instrument_name) do
    query =
      from i in "instruments",
        where: i.name == ^instrument_name,
        select: {i.id}

    SubTrackerElixir.Repo.all(query)
    |> List.first()
    |> elem(0)
  end

  def add_instrument(instrument_name) do
    %SubTrackerElixir.Instrument{name: instrument_name}
    |> SubTrackerElixir.Repo.insert()
  end

  def update_instrument(instrument_id, instrument_name) do
    instrument = SubTrackerElixir.Repo.get!(SubTrackerElixir.Instrument, instrument_id)
    changeset = change(instrument, %{name: instrument_name})
    SubTrackerElixir.Repo.update(changeset)
  end

  def delete_instrument(instrument_id) do
    instrument = SubTrackerElixir.Repo.get!(SubTrackerElixir.Instrument, instrument_id)
    SubTrackerElixir.Repo.delete(instrument)
  end

  def load_page(page_num) do
    # TODO:add error validation later
    if page_num == nil do
      1
    else
      String.to_integer(page_num)
    end
  end

  def pagination_necessary?(item_count) do
    item_count > @items_per_page
  end

  def first_page?(current_page) do
    current_page == 1
  end

  def last_page?(current_page, last_page) do
    current_page == last_page
  end

  def find_current_visible_page_range(item_count, current_page) do
    chunked = Enum.chunk_every(1..item_count, 5, 1, :discard)

    Enum.filter(chunked, fn subarr -> Enum.at(subarr, div(length(subarr), 2)) == current_page end)
    |> List.flatten()
  end

  def find_pagination_slice_min(item_count, current_page) do
    page_range = find_current_visible_page_range(item_count, current_page)
    Enum.min(page_range)
  end

  def find_pagination_slice_max(item_count, current_page) do
    page_range = find_current_visible_page_range(item_count, current_page)
    Enum.max(page_range)
  end

  def find_pagination_min_page(current_page, last_page, item_count) do
    cond do
      current_page <= div(@num_pages_visible, 2) ->
        1

      current_page >= last_page - div(@num_pages_visible, 2) ->
        max(last_page - @num_pages_visible + 1, 1)

      true ->
        find_pagination_slice_min(item_count, current_page)
    end
  end

  def find_pagination_max_page(current_page, last_page, item_count) do
    cond do
      current_page <= div(@num_pages_visible, 2) ->
        min(last_page, @num_pages_visible)

      current_page >= last_page - div(@num_pages_visible, 2) ->
        last_page

      true ->
        find_pagination_slice_max(item_count, current_page)
    end
  end

  def find_last_page_number(item_count) do
    if rem(item_count, @num_pages_visible) == 0 do
      div(item_count, @num_pages_visible)
    else
      div(item_count, @num_pages_visible) + 1
    end
  end
end
