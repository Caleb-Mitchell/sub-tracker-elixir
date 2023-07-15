defmodule SubTrackerElixirWeb.Router do
  use SubTrackerElixirWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SubTrackerElixirWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SubTrackerElixirWeb do
    pipe_through :browser

    get "/", InstrumentController, :home

    get "/instruments", InstrumentController, :index
    get "/instruments/new", InstrumentController, :new
    get "/instruments/:id/edit", InstrumentController, :edit

    post "/instruments", InstrumentController, :create
    post "/instruments/:id/delete", InstrumentController, :delete
    post "/instruments/:id/update", InstrumentController, :update

    get "/instruments/:id", MusicianController, :index
    get "/instruments/:instrument_id/musicians/new", MusicianController, :new
    get "/instruments/:instrument_id/musicians/:musician_id/edit", MusicianController, :edit

    post "/instruments/:instrument_id/musicians", MusicianController, :create
    post "/instruments/:instrument_id/musicians/:musician_id/delete", MusicianController, :delete
    post "/instruments/:instrument_id/musicians/:musician_id/update", MusicianController, :update
  end

  # convention TODO: remove this
  # index - renders a list of all items of the given resource type
  # show - renders an individual item by ID
  # new - renders a form for creating a new item
  # create - receives parameters for one new item and saves it in a data store
  # edit - retrieves an individual item by ID and displays it in a form for editing
  # update - receives parameters for one edited item and saves the item to a data store
  # delete - receives an ID for an item to be deleted and deletes it from a data store

  # Other scopes may use custom stacks.
  # scope "/api", SubTrackerElixirWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:sub_tracker_elixir, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SubTrackerElixirWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
