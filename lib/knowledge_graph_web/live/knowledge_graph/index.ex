defmodule KnowledgeGraphWeb.KnowledgeGraphLive.Index do
  use KnowledgeGraphWeb, :live_view
  alias KnowledgeGraph.Nodes

  def mount(_params, _session, socket) do
    nodes = Nodes.list_nodes()
    {:ok, assign(socket, nodes: nodes)}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl font-bold text-center text-gray-800">Knowledge Graph</h1>
    <.link navigate={~p"/knowledge-graph/create"}>
      <.button>Create</.button>
    </.link>
    <ul>
      <%= for node <- @nodes do %>
        <.link navigate={~p"/knowledge-graph/#{node.id}"}>
          <li>
            <%= node.name %> (Links: <%= Enum.count(node.links) %>, Back links: <%= Enum.count(
              node.back_links
            ) %>)
          </li>
        </.link>
      <% end %>
    </ul>
    """
  end
end
