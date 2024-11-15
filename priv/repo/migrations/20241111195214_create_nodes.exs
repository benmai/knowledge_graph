defmodule KnowledgeGraph.Repo.Migrations.CreateNodes do
  use Ecto.Migration

  def change do
    create table(:node) do
      add :name, :string
      add :description, :text
      add :urls, {:array, :string}
    end

    create table(:link) do
      add :from_id, references(:node, on_delete: :delete_all)
      add :to_id, references(:node, on_delete: :delete_all)
      add :label, :string
      add :properties, :map
    end
  end
end
