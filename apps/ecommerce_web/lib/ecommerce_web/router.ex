defmodule EcommerceWeb.Router do
  use EcommerceWeb, :router

  pipeline :graphql do
    plug :accepts, ["json"]
    plug Ecommerce.Context
  end

  scope "/api" do
    pipe_through :graphql
    forward "/", Absinthe.Plug, schema: EcommerceWeb.Graphql.Schema
  end

  if Mix.env() == :dev do
    pipe_through :graphql
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: EcommerceWeb.Graphql.Schema
  end
end
