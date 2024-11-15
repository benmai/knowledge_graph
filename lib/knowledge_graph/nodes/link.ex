defmodule KnowledgeGraph.Link do
  use Ecto.Schema
  # import Ecto.Changeset

  schema "link" do
    field :from_id, :id
    field :to_id, :id
    field :label, :string
    field :properties, :map

    has_one :from, KnowledgeGraph.Node, foreign_key: :from_id
    has_one :to, KnowledgeGraph.Node, foreign_key: :to_id
  end
end
