defmodule SubTrackerElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SubTrackerElixirWeb.Telemetry,
      # Start the Ecto repository
      SubTrackerElixir.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: SubTrackerElixir.PubSub},
      # Start Finch
      {Finch, name: SubTrackerElixir.Finch},
      # Start the Endpoint (http/https)
      SubTrackerElixirWeb.Endpoint
      # Start a worker by calling: SubTrackerElixir.Worker.start_link(arg)
      # {SubTrackerElixir.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SubTrackerElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SubTrackerElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
