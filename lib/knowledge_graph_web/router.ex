defmodule KnowledgeGraphWeb.Router do
  use KnowledgeGraphWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {KnowledgeGraphWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KnowledgeGraphWeb do
    pipe_through :browser

    live "/", KnowledgeGraphLive.Index

    live "/knowledge-graph", KnowledgeGraphLive.Index
    live "/knowledge-graph/create", KnowledgeGraphLive.Create
    live "/knowledge-graph/:slug", KnowledgeGraphLive.Show
  end

  # Other scopes may use custom stacks.
  # scope "/api", KnowledgeGraphWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:knowledge_graph, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: KnowledgeGraphWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
