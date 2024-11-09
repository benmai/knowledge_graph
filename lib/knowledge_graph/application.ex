defmodule KnowledgeGraph.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      KnowledgeGraphWeb.Telemetry,
      KnowledgeGraph.Repo,
      {DNSCluster, query: Application.get_env(:knowledge_graph, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: KnowledgeGraph.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: KnowledgeGraph.Finch},
      # Start a worker by calling: KnowledgeGraph.Worker.start_link(arg)
      # {KnowledgeGraph.Worker, arg},
      # Start to serve requests, typically the last entry
      KnowledgeGraphWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KnowledgeGraph.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KnowledgeGraphWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
