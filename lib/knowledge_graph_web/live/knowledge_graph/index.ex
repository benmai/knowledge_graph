defmodule KnowledgeGraphWeb.KnowledgeGraphLive.Index do
  use KnowledgeGraphWeb, :live_view

  def mount(_params, _session, socket) do
    nodes = KnowledgeGraph.KnowledgeGraph.list_nodes()
    {:ok, assign(socket, nodes: nodes)}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl font-bold text-center text-gray-800">Knowledge Graph</h1>
    <ul>
      <%= for node <- @nodes do %>
        <.link navigate={~p"/knowledge-graph/#{node.id}"}>
          <li><%= node.title %></li>
        </.link>
      <% end %>
    </ul>
    """
  end
end
