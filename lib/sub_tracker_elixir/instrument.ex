defmodule SubTrackerElixir.Instrument do
  use Ecto.Schema

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
        distinct: true,
        left_join: m in "musicians",
        on: i.id == m.instrument_id,
        order_by: i.name,
        select: {i.name, i.id}

    SubTrackerElixir.Repo.all(query)
    |> Enum.map(fn {name, id} -> %{name: name, id: id} end)
  end

  def find_item_count(instrument_list) do
    length(instrument_list)
  end

  def load_page do
    # TODO:flesh out logic for other pages soon
    1
  end

  def find_pagination_min_page(current_page, last_page) do
    cond do
      current_page <= div(@num_pages_visible, 2) ->
        # TODO: does current page need to be converted to a string
        1

      current_page >= last_page - div(@num_pages_visible, 2) ->
        max(last_page - @num_pages_visible + 1, 1)
        # true ->
        #   find_pagination_low_slice(item_count)
    end
  end

  def find_pagination_max_page(current_page, last_page) do
    cond do
      current_page <= div(@num_pages_visible, 2) ->
        min(last_page, @num_pages_visible)

      current_page >= last_page - div(@num_pages_visible, 2) ->
        last_page
        # true ->
        #   find_pagination_low_slice(item_count)
    end
  end

  def find_last_page_number(item_count) do
    if rem(item_count, @num_pages_visible) == 0 do
      div(item_count, @num_pages_visible)
    else
      div(item_count, @num_pages_visible + 1)
    end
  end
end
