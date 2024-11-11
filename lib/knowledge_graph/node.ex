defmodule KnowledgeGraph.Node do
  use Ecto.Schema

  schema "node" do
    field :name, :string
    field :description, :string
    field :urls, {:array, :string}
  end
end
