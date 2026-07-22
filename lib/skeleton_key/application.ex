defmodule SkeletonKey.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SkeletonKeyWeb.Telemetry,
      SkeletonKey.Repo,
      {DNSCluster, query: Application.get_env(:skeleton_key, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SkeletonKey.PubSub},
      # Start a worker by calling: SkeletonKey.Worker.start_link(arg)
      # {SkeletonKey.Worker, arg},
      # Start to serve requests, typically the last entry
      SkeletonKeyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SkeletonKey.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SkeletonKeyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
