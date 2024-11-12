defmodule KnowledgeGraphWeb.KnowledgeGraphLive.Show do
  use KnowledgeGraphWeb, :live_view

  import KnowledgeGraphWeb.CustomComponents

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"slug" => slug}, _uri, socket) do
    {id, current_slug} = String.split(slug, "-", parts: 2) |> parse_id_slug_result()

    node = KnowledgeGraph.Repo.get(KnowledgeGraph.Node, id)

    socket = assign(socket, node: node)

    should_be_slug = Slug.slugify(node.name)

    if current_slug != should_be_slug do
      {:noreply,
       push_patch(
         socket,
         to: ~p"/knowledge-graph/#{id <> "-" <> should_be_slug}",
         replace: true
       )}
    else
      {:noreply, socket}
    end
  end

  def parse_id_slug_result([id, slug]) do
    {id, slug}
  end

  def parse_id_slug_result([id]) do
    {id, ""}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl font-bold text-center text-gray-800"><%= @node.name %></h1>
    <.markdown text={@node.description} />
    <ul>
      <%= for url <- @node.urls do %>
        <li><a href={url}><%= url %></a></li>
      <% end %>
    </ul>
    <.back navigate={~p"/knowledge-graph"}>Back</.back>
    """
  end
end
