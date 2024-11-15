defmodule KnowledgeGraph.Node do
  use Ecto.Schema
  import Ecto.Changeset

  schema "node" do
    field :name, :string
    field :description, :string
    field :urls, {:array, :string}

    has_many :back_links, KnowledgeGraph.Link, foreign_key: :to_id
    has_many :links, KnowledgeGraph.Link, foreign_key: :from_id, foreign_key: :from_id
  end

  def changeset(node, attrs) do
    node
    |> cast(attrs, [:name, :description, :urls])
    |> validate_required([:name, :description, :urls])
  end
end
