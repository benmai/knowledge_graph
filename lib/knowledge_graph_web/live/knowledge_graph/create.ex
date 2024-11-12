defmodule KnowledgeGraphWeb.KnowledgeGraphLive.Create do
  use KnowledgeGraphWeb, :live_view
  alias KnowledgeGraph.Repo
  alias KnowledgeGraph.Node

  def mount(_params, _session, socket) do
    changeset = Node.changeset(%Node{urls: [""]})
    {:ok, assign(socket, changeset: changeset, form: to_form(changeset))}
  end

  def render(assigns) do
    ~H"""
    <%= inspect(@changeset) %>
    <%= inspect(@form) %> Change <%= inspect(Ecto.Changeset.get_field(@changeset, :urls, [""])) %>

    <div class="max-w-lg mx-auto p-4">
      <h1 class="text-4xl font-bold text-center text-gray-800 mb-6">Create Knowledge Graph Item</h1>
      <form phx-submit="save" phx-change="validate" class="space-y-4">
        <div>
          <label for="name" class="block text-sm font-medium text-gray-700">Name</label>
          <input
            type="text"
            name="name"
            value={Ecto.Changeset.get_field(@changeset, :name)}
            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
          />
          <p class="text-red-500 text-xs italic"><%= inspect(@changeset.errors[:name]) %></p>
        </div>

        <div>
          <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
          <textarea
            name="description"
            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
          ><%= Ecto.Changeset.get_field(@changeset, :description) %></textarea>
          <p class="text-red-500 text-xs italic"><%= inspect(@changeset.errors[:description]) %></p>
        </div>

        <label for="urls" class="block text-sm font-medium text-gray-700">URLs</label>
        <div :for={url <- Ecto.Changeset.get_field(@changeset, :urls, [""])}>
          <input
            type="text"
            name="urls[]"
            value={url}
            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
            placeholder="https://en.wikipedia.com/..."
          />
        </div>
        <p class="text-red-500 text-xs italic"><%= inspect(@changeset.errors[:urls]) %></p>

        <div class="flex justify-end">
          <button
            type="submit"
            class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
          >
            Save
          </button>
        </div>
      </form>
    </div>
    <.back navigate={~p"/knowledge-graph"}>Back</.back>
    """
  end

  def handle_event("validate", node_params, socket) do
    changeset =
      Ecto.Changeset.cast(%Node{}, node_params, [:name, :description, :urls], empty_values: [])

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", node_params, socket) do
    changeset =
      Ecto.Changeset.cast(%Node{}, node_params, [:name, :description, :urls], empty_values: [])

    if changeset.valid? do
      res = Repo.insert!(changeset)
      {:noreply, push_navigate(socket, to: ~p"/knowledge-graph/#{res.id}")}
    else
      {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
