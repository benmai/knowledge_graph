# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     KnowledgeGraph.Repo.insert!(%KnowledgeGraph.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias KnowledgeGraph.Repo

Path.join([:code.priv_dir(:knowledge_graph), "repo", "nodes.json"])
|> File.read!()
|> Poison.decode!(as: [%KnowledgeGraph.Node{}])
|> Enum.each(fn node -> Repo.insert!(node) end)
