defmodule KnowledgeGraphWeb.KnowledgeGraphLive.Index do
  use KnowledgeGraphWeb, :live_view

  def mount(_params, _session, socket) do
    nodes = KnowledgeGraph.Repo.all(KnowledgeGraph.Node)
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
          <li><%= node.name %></li>
        </.link>
      <% end %>
    </ul>
    """
  end
end
