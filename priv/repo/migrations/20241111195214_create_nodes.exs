defmodule KnowledgeGraph.Repo.Migrations.CreateNodes do
  use Ecto.Migration

  def change do
    create table(:node) do
      add :name, :string
      add :description, :text
      add :urls, {:array, :string}
    end
  end
end
