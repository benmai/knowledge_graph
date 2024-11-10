defmodule KnowledgeGraph.Node do
  defstruct id: "", links: [], title: "", description: "", urls: []
end

defmodule KnowledgeGraph.Link do
  defstruct description: "", id: ""
end

defmodule KnowledgeGraph.KnowledgeGraph do
  def list_nodes() do
    # It's not possible to declare this at the module level since that's evaluated
    # at compile-time.
    Path.join([:code.priv_dir(:knowledge_graph), "repo", "nodes.json"])
    |> File.read!()
    |> Poison.decode!(as: [%KnowledgeGraph.Node{links: [%KnowledgeGraph.Link{}]}])
  end

  def get_node!(id) do
    list_nodes()
    |> Enum.find(&(&1.id == id))
  end
end
