defmodule KnowledgeGraph.Repo do
  use Ecto.Repo,
    otp_app: :knowledge_graph,
    adapter: Ecto.Adapters.SQLite3
end
