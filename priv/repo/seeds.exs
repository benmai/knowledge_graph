# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     KnowledgeGraph.Repo.insert!(%KnowledgeGraph.SomeSchemaRepo.insert! %Node{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias KnowledgeGraph.Repo
alias KnowledgeGraph.Node
alias KnowledgeGraph.Link

Repo.insert!(%Node{
  name: "Impostor syndrome",
  urls: ["https://en.wikipedia.org/wiki/Impostor_syndrome"],
  description: "Doubting accomplishments, fear of being exposed as a fraud."
})

Repo.insert!(%Node{
  name: "Event Sourcing",
  urls: ["https://microservices.io/patterns/data/event-sourcing.html"],
  description: "Pattern of using events as the source of truth for data storage."
})

Repo.insert!(%Node{
  name: "Golang",
  urls: ["https://golang.org/"],
  description:
    "Programming language. Go has a very powerful standard library, making it easy to write code without an excessive number of dependencies. It also has built-in support for open-source dependencies, so it doesn't require an external package manager."
})

Repo.insert!(%Node{
  name: "JavaScript",
  urls: [
    "https://www.javascript.com/",
    "https://en.wikipedia.org/wiki/JavaScript"
  ],
  description: "Programming language."
})

Repo.insert!(%Node{
  name: "TypeScript",
  urls: ["https://www.typescriptlang.org/"],
  description:
    "TypeScript is a strongly-typed variant of JavaScript. It adds additional safety and scalability at the cost of ease of project startup time."
})

Repo.insert!(%Node{
  name: "The Design of Everyday Things",
  urls: ["https://en.wikipedia.org/wiki/The_Design_of_Everyday_Things"],
  description: "Maximize intuitive guidance in objects."
})

Repo.insert!(%Node{
  name: "The Minto Pyramid Principle",
  urls: ["http://www.barbaraminto.com/"],
  description:
    "A way to organize information to be maximally understandable. One of the more compelling pieces of this to me is to always start with somnething that you agree on."
})

Repo.insert!(%Node{
  name: "React",
  urls: ["https://reactjs.org/"],
  description:
    "An unopinionated JavaScript framework. The primary features are a) declarativeness and b) HTML-like syntax called JSX."
})

Repo.insert!(%Node{
  name: "Stanford duck syndrome",
  urls: [
    "https://www.stanforddaily.com/2018/01/31/duck-syndrome-and-a-culture-of-misery/"
  ],
  description:
    "When a person puts effort into appearing effortless, when under the surface they are struggling."
})

Repo.insert!(%Node{
  name: "Monkey on the back",
  urls: ["https://hbr.org/1999/11/management-time-whos-got-the-monkey"],
  description:
    "When a manager doesn't give a subordinate the tools to meaningfully address a problem to the manager's satisfaction."
})

Repo.insert!(%Node{
  name: "Atomic Design",
  urls: ["https://bradfrost.com/blog/post/atomic-web-design/"],
  description: "A way of creating design systems that emphasizes composability and reusability."
})

Repo.insert!(%Node{
  name: "Code linting",
  urls: ["https://en.wikipedia.org/wiki/Lint_(software)"],
  description: "A tool to analyze source code to find errors as well as stylistic problems."
})

Repo.insert!(%Node{
  name: "Consciouesness/competence model",
  urls: [
    "https://en.wikipedia.org/wiki/Four_stages_of_competence",
    "https://medium.com/@zainabz/the-four-stages-of-competence-ee5c6046b205"
  ],
  description:
    "There are four stages to knowledge acquisition:\n\n1. **Unconscious incompetence**: You don't know what you don't know.\n\n1. **Conscious incompetence**: You know what you don't know.\n\n1. **Conscious competence**: You know, but you have to think about it.\n\n1. **Unconscious competence**: You know, and you don't have to think about it.\n\n![](https://miro.medium.com/max/674/1*wQz9hug8PWf2ke0eqE3-yg.jpeg)"
})

Repo.insert!(%Node{
  name: "CAP theorem",
  urls: ["https://en.wikipedia.org/wiki/CAP_theorem"],
  description: "Consitency, availability, partition-tolerance -- pick two."
})

Repo.insert!(%Node{
  name: "Technical debt",
  description:
    "Features of code which make it difficult to maintain or extend. While frequently taken on to hit deadlines, technical debt can also be the result of poor foresight.\n",
  urls: [
    "https://hackernoon.com/there-are-3-main-types-of-technical-debt-heres-how-to-manage-them-4a3328a4c50c"
  ]
})

Repo.insert!(%Node{
  name: "Refactoring",
  description:
    "When a developer rewrites code to be more extensible, legible, or maintainable.\n",
  urls: []
})

Repo.insert!(%Node{
  name: "\"I\" statements",
  description:
    "Feedback statements in the form **I feel _blank_ when you _blank_. Please _blank_.** They help the feedback receiver focus attention on the feedback giver rather than their own faults.\n",
  urls: []
})

Repo.insert!(%Link{
  from_id: Repo.get_by!(Node, name: "JavaScript").id,
  to_id: Repo.get_by(Node, name: "TypeScript").id,
  label: "LINK",
  properties: %{"description" => "TypeScript transpiles to JavaScript."}
})

Repo.insert!(%Link{
  from_id: Repo.get_by!(Node, name: "Refactoring").id,
  to_id: Repo.get_by!(Node, name: "Technical debt").id,
  properties: %{
    "description" =>
      "Code refactoring can be a way to combat technical debt, but when taken overboard can also contribute to it due to over-abstraction."
  }
})

Repo.insert!(%Link{
  from_id: Repo.get_by!(Node, name: "Stanford duck syndrome").id,
  to_id: Repo.get_by!(Node, name: "Impostor syndrome").id,
  properties: %{
    "description" =>
      "Duck syndrome can contribute to impostor syndrome. When it appears that everyone else's work is effortless, the fact that one's own work is not is disturbing."
  }
})

Repo.insert!(%Link{
  from_id: Repo.get_by!(Node, name: "React").id,
  to_id: Repo.get_by!(Node, name: "JavaScript").id,
  properties: %{"description" => "React is a framework written in JavaScript."}
})
