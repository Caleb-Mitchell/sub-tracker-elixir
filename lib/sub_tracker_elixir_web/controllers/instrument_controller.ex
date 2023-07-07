defmodule SubTrackerElixirWeb.InstrumentController do
  use SubTrackerElixirWeb, :controller

  def instruments(conn, _params) do
    render(conn, :instruments, page_title: "Instrument List")
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
