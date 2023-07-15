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
    # TODO: check these fields populate on error
    musician_email = conn.params["musician_email"]

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

  def create(conn, _params) do
    name = String.trim(conn.params["musician_name"])
    phone = String.trim(conn.params["musician_phone"])
    email = String.trim(conn.params["musician_email"])

    instrument_name = String.trim(conn.params["musician_instrument"])

    instrument_id =
      Instrument.find_instrument_id(instrument_name)

    IO.inspect(instrument_id)
    Musician.add_musician(name, phone, email, instrument_id)
    redirect(conn, to: ~p"/instruments/#{instrument_id}")

    #   changeset = Musician.changeset(%Musician{}, musician_params)
    #
    #   case SubTrackerElixir.Repo.insert(changeset) do
    #     {:ok, _musician} ->
    #       conn
    #       |> put_flash(:info, "Musician created successfully.")
    #       |> redirect(to: Routes.musician_path(conn, :index, musician_params["instrument_id"]))
    #
    #     {:error, changeset} ->
    #       current_instrument = Instrument.load_instrument(musician_params["instrument_id"]).name
    #       instrument_list = Instrument.list_instruments()
    #
    #       render(conn,
    #         page_title: "Add new musician that plays #{current_instrument}.",
    #         instrument_id: musician_params["instrument_id"],
    #         current_instrument: current_instrument,
    #         instrument_list: instrument_list,
    #         changeset: changeset
    #       )
    #   end
    # end
  end

  def delete(conn, %{"instrument_id" => instrument_id, "musician_id" => musician_id}) do
    Musician.delete_musician(musician_id)
    redirect(conn, to: ~p"/instruments/#{instrument_id}")
  end

  def edit(conn, %{"instrument_id" => instrument_id, "musician_id" => musician_id}) do
    current_instrument = Instrument.load_instrument(instrument_id).name
    instrument_list = Instrument.list_instruments()

    current_musician = Musician.load_musician(musician_id)

    new_name = conn.params["musician_name"]
    new_phone = conn.params["musician_phone"]
    new_email = conn.params["musician_email"]

    render(conn,
      page_title: "Update Musician Information",
      instrument_id: instrument_id,
      musician_id: musician_id,
      current_instrument: current_instrument,
      instrument_list: instrument_list,
      current_musician: current_musician,
      new_name: new_name,
      new_phone: new_phone,
      new_email: new_email
    )
  end

  def update(conn, %{"musician_id" => musician_id}) do
    name = String.trim(conn.params["musician_name"])
    phone = String.trim(conn.params["musician_phone"])
    email = String.trim(conn.params["musician_email"])
    instrument_name = conn.params["musician_instrument"]

    instrument_id =
      Instrument.find_instrument_id(instrument_name)

    Musician.update_musician(musician_id, name, phone, email, instrument_id)
    redirect(conn, to: ~p"/instruments/#{instrument_id}")
  end
end
