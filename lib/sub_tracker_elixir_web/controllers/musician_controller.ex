defmodule SubTrackerElixirWeb.MusicianController do
  use SubTrackerElixirWeb, :controller
  import SubTrackerElixir.Instrument

  alias SubTrackerElixir.{Musician, Instrument}

  def index(conn, %{"id" => id}) do
    current_instrument = Instrument.load_instrument(id).name
    musician_list = Musician.list_musicians(String.to_integer(id))
    # musician_count = length(musician_list)

    # page_num = Instrument.load_page(conn.params["page"])
    # musician_page_list = Musician.musicians_page(page_num)
    #
    # last_page = Musician.find_last_page_number(musician_count)
    # min_page = Musician.find_pagination_min_page(page_num, last_page, musician_count)
    # max_page = Musician.find_pagination_max_page(page_num, last_page, musician_count)

    render(
      conn,
      page_title: "Musicians who play: #{current_instrument}.",
      current_instrument: current_instrument,
      instrument_id: id,
      musician_list: musician_list
      # musician_page_list: musician_page_list,
      # musician_count: musician_count,
      # min_page: min_page,
      # max_page: max_page,
      # page_num: page_num,
      # last_page: last_page
    )
  end
end
