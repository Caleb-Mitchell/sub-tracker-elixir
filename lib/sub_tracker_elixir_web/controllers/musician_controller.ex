defmodule SubTrackerElixirWeb.MusicianController do
  use SubTrackerElixirWeb, :controller

  alias SubTrackerElixir.{Musician, Instrument}

  def index(conn, %{"id" => id}) do
    current_instrument = Instrument.load_instrument(id).name
    musician_list = Musician.list_musicians(String.to_integer(id))
    musician_count = length(musician_list)

    page_num = Instrument.load_page(conn.params["page"])
    musician_page_list = Musician.musicians_page(page_num, String.to_integer(id))

    last_page = Instrument.find_last_page_number(musician_count)
    min_page = Instrument.find_pagination_min_page(page_num, last_page, musician_count)
    max_page = Instrument.find_pagination_max_page(page_num, last_page, musician_count)

    render(conn,
      page_title: "Musicians who play: #{current_instrument}.",
      instrument_id: id,
      current_instrument: current_instrument,
      musician_list: musician_list,
      musician_page_list: musician_page_list,
      musician_count: musician_count,
      min_page: min_page,
      max_page: max_page,
      page_num: page_num,
      last_page: last_page
    )
  end

  def new(conn, %{"instrument_id" => id}) do
    current_instrument = Instrument.load_instrument(id).name
    instrument_list = Instrument.list_instruments()

    musician_name = conn.params["musician_name"]
    musician_phone = conn.params["musician_phone"]
    musician_email = conn.params["musician_email"] # TODO: check these fields populate on error

    render(conn,
      page_title: "Add new musician that plays #{current_instrument}.",
      instrument_id: id,
      current_instrument: current_instrument,
      instrument_list: instrument_list,
      musician_name: musician_name,
      musician_phone: musician_phone,
      musician_email: musician_email
    )
  end
end
