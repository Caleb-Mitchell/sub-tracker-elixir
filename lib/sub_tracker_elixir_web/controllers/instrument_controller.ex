defmodule SubTrackerElixirWeb.InstrumentController do
  use SubTrackerElixirWeb, :controller

  alias SubTrackerElixir.Instrument

  def home(conn, _params) do
    redirect(conn, to: ~p"/instruments")
  end

  def index(conn, _params) do
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
    # require_signed_in_user
    #
    # error = error_for_instrument(instrument_name)
    # if error
    #   session[:error] = error
    #   status 422
    #   @title = "Add New Instrument"
    #
    #   erb :new_instrument
    # else
    #   @storage.add_instrument(instrument_name)
    #   redirect "/instruments"
    # end
    # end

    instrument_name = String.trim(conn.params["instrument_name"])
    IO.inspect("Words here!!")

    Instrument.add_instrument(instrument_name)
    redirect(conn, to: ~p"/instruments")
  end
end
