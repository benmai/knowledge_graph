defmodule KnowledgeGraph.Node do
  defstruct id: "", links: [], title: "", description: "", urls: []
end

defmodule KnowledgeGraph.Link do
  defstruct description: "", id: ""
end

defmodule KnowledgeGraph.KnowledgeGraph do
  # Current working directory concatenated with the path to the nodes file
  # @nodes_path Path.join([:code.priv_dir(:knowledge_graph), "repo", "nodes.json"])

  def list_nodes() do
    # @nodes_path
    # |> File.read!()
    # |> Poison.decode!(as: [%KnowledgeGraph.Node{links: [%KnowledgeGraph.Link{}]}])

    []
  end

  def get_node!(id) do
    list_nodes()
    |> Enum.find(&(&1.id == id))
  end
end
