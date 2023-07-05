defmodule SubTrackerElixir.Repo do
  use Ecto.Repo,
    otp_app: :sub_tracker_elixir,
    adapter: Ecto.Adapters.Postgres
end
