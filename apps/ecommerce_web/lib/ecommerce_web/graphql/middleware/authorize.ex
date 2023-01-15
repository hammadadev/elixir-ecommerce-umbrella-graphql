defmodule EcommerceWeb.Graphql.Schema.Middleware.Authorize do
  @behaviour Absinthe.Middleware
  def call(res, identifier) do
    IO.inspect(identifier, label: "IDENTIFIER")

    with %{current_user: _current_user} <- res.context do
      res
    else
      _ ->
        res
        |> Absinthe.Resolution.put_result({:error, "unauthorized"})
    end
  end
end
