defmodule SubTrackerElixirWeb.InstrumentController do
  use SubTrackerElixirWeb, :controller
  # import Ecto.Query
  # import Ecto.Queryable
  # import Ecto.Association

  def instruments(conn, _params) do
    # render(conn, :instruments, page_title: "Instrument List")
    # conn
    # |> assign(:page_title, "Instrument List")
    # select * from instruments, order by name

    # |> assign(:instruments_page_list, Enum.map(SubTrackerElixir.Instrument |> SubTrackerElixir.Repo.all, &Map.from_struct/1))
    # |> assign(:instruments_page_list, Enum.map(SubTrackerElixir.Instrument |> SubTrackerElixir.Repo.all(), &(&1.name)))
    # |> assign(:instruments_page_list,
    #   SubTrackerElixir.Instrument
    #     |> SubTrackerElixir.Repo.all
    #     |> Repo.preload([:musicians])
    # )

    instrument_list = SubTrackerElixir.Repo.all(SubTrackerElixir.Instrument)
      |> SubTrackerElixir.Repo.preload(:musicians)

    render(conn, page_title: "Instrument List", instrument_page_list: instrument_list)
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
