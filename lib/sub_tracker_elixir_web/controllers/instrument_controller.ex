defmodule SubTrackerElixirWeb.InstrumentController do
  use SubTrackerElixirWeb, :controller

  import Ecto.Query

  def instruments(conn, _params) do
    query =
      from i in "instruments",
        distinct: true,
        left_join: m in "musicians",
        on: i.id == m.instrument_id,
        order_by: i.name,
        select: {i.name, i.id}

    instrument_list =
      SubTrackerElixir.Repo.all(query)
      |> Enum.map(fn {name, id} -> %{name: name, id: id} end)

    instrument_count = length(instrument_list)

    render(conn,
      page_title: "Instrument List",
      instrument_list: instrument_list,
      instrumnet_count: instrument_count
    )
  end

  # here is what i need to have access to via `assigns` to display
  # the rest of my dynamic html for my instruments page

  # @instrument_count = @storage.total_instrument_count
  # @last_page = find_last_page_number(@instrument_count)
  # @page_num = load_page(params[:page], @last_page) || 1
  # @min_page, @max_page = find_min_and_max_page_num(@last_page,
  #                                                  @instrument_count)
  # @instruments_page_list = @storage.instruments_page(@page_num)
end
