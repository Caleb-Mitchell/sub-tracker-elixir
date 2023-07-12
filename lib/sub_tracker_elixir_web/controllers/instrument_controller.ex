defmodule SubTrackerElixirWeb.InstrumentController do
  use SubTrackerElixirWeb, :controller

  alias SubTrackerElixir.Instrument

  def instruments(conn, _params) do
    instrument_list = Instrument.list_instruments()
    instrument_count = Instrument.find_item_count(instrument_list)

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
end
