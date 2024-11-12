defmodule KnowledgeGraph.Node do
  use Ecto.Schema
  import Ecto.Changeset

  schema "node" do
    field :name, :string
    field :description, :string
    field :urls, {:array, :string}
  end

  def changeset(node, params \\ %{}) do
    node
    |> cast(params, [:name, :description, :urls])
    |> validate_required([:name, :description, :urls])
  end
end
