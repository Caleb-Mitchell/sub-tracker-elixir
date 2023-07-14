defmodule SubTrackerElixirWeb.InstrumentController do
  use SubTrackerElixirWeb, :controller

  alias SubTrackerElixir.Instrument

  def home(conn, _params) do
    redirect(conn, to: ~p"/instruments")
  end

  def index(conn, _params) do
    instrument_list = Instrument.list_instruments()
    instrument_count = length(instrument_list)

    page_num = Instrument.load_page(conn.params["page"])
    instrument_page_list = Instrument.instruments_page(page_num)

    last_page = Instrument.find_last_page_number(instrument_count)
    min_page = Instrument.find_pagination_min_page(page_num, last_page, instrument_count)
    max_page = Instrument.find_pagination_max_page(page_num, last_page, instrument_count)

    render(conn,
      page_title: "Instrument List",
      instrument_list: instrument_list,
      instrument_page_list: instrument_page_list,
      instrument_count: instrument_count,
      min_page: min_page,
      max_page: max_page,
      page_num: page_num,
      last_page: last_page
    )
  end

  def edit(conn, %{"id" => id}) do
    instrument = Instrument.load_instrument(id)

    render(conn,
      page_title: "Update Instrument Name",
      instrument_name: instrument.name,
      instrument_id: instrument.id
    )
  end

  def update(conn, %{"id" => id}) do
    instrument_name = String.trim(conn.params["instrument_name"])
    Instrument.update_instrument(id, instrument_name)

    redirect(conn, to: ~p"/instruments")
  end

  def new(conn, _params) do
    render(conn,
      page_title: "Add New Instrument"
    )
  end

  def delete(conn, %{"id" => id}) do
    Instrument.delete_instrument(id)
    redirect(conn, to: ~p"/instruments")
  end

  def create(conn, _params) do
    instrument_name = String.trim(conn.params["instrument_name"])
    Instrument.add_instrument(instrument_name)

    redirect(conn, to: ~p"/instruments")
  end
end
