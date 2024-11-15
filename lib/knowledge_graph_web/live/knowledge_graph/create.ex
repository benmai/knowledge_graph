defmodule KnowledgeGraphWeb.KnowledgeGraphLive.Create do
  use KnowledgeGraphWeb, :live_view
  alias KnowledgeGraph.Nodes
  alias KnowledgeGraph.Node

  def mount(_params, _session, socket) do
    socket =
      attach_hook(socket, :log_form, :after_render, fn socket ->
        IO.inspect(socket.assigns.form[:urls])
        socket
      end)

    {:ok, assign(socket, form: to_form(%{"urls" => [""]}))}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-lg mx-auto p-4">
      <h1 class="text-4xl font-bold text-center text-gray-800 mb-6">Create Knowledge Graph Item</h1>
      <.create_form form={@form} />
    </div>
    <.back navigate={~p"/knowledge-graph"}>Back</.back>
    """
  end

  def create_form(assigns) do
    ~H"""
    <.form id="create-form" for={@form} phx-submit="save" phx-change="validate" class="space-y-4">
      <div>
        <label for="name" class="block text-sm font-medium text-gray-700">Name</label>
        <.input
          field={@form[:name]}
          type="text"
          class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
        />
        <%!-- <p class="text-red-500 text-xs italic"><%= inspect(@changeset.errors[:name]) %></p> --%>
      </div>

      <div>
        <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
        <.input
          type="textarea"
          field={@form[:description]}
          class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
        />
      </div>

      <label for="urls" class="block text-sm font-medium text-gray-700">URLs</label>
      <input
        :for={url <- @form[:urls].value}
        type="text"
        name="urls[]"
        value={url}
        class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
        placeholder="https://en.wikipedia.com/..."
      />
      <%!-- <p class="text-red-500 text-xs italic"><%= inspect(@changeset.errors[:urls]) %></p> --%>

      <div class="flex justify-end">
        <button
          type="submit"
          class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
        >
          Save
        </button>
      </div>
    </.form>
    """
  end

  def handle_event("validate", node_params, socket) do
    {:noreply, assign(socket, form: to_form(node_params))}
  end

  def handle_event("save", node_params, socket) do
    # TODO: handle bad input.
    changeset = Node.changeset(%Node{}, node_params)
    {:ok, node} = Nodes.create_node(changeset)
    {:noreply, push_navigate(socket, to: ~p"/knowledge-graph/#{node.id}")}
  end
end
