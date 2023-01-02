defmodule EcommerceWeb.Router do
  use EcommerceWeb, :router

  pipeline :graphql do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :graphql
    forward "/", Absinthe.Plug, schema: EcommerceWeb.Graphql.Schema
  end

  if Mix.env() == :dev do
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: EcommerceWeb.Graphql.Schema
  end
end
