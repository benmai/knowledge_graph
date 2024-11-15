# defmodule KnowledgeGraph.Link do
#   defstruct description: "", id: ""
# end

defmodule KnowledgeGraph.Nodes do
  alias KnowledgeGraph.Repo
  alias KnowledgeGraph.Node

  import Ecto.Query

  def list_nodes() do
    Node
    |> preload([:links, :back_links])
    |> Repo.all()
  end

  def get_node(id) do
    Node
    |> preload([:links, :back_links])
    |> Repo.get(id, preload: :links)
  end

  def create_node(node) do
    Repo.insert(node)
  end
end
