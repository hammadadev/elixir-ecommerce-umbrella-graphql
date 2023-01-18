defmodule EcommerceWeb.Graphql.Schema.Middleware.Authorize do
  @behaviour Absinthe.Middleware
  @unproctected_fields [:login, :create_user]
  def call(res, identifier) do
    with %{current_user: _current_user} <- res.context do
      res
    else
      _ ->
        if identifier in @unproctected_fields do
          res
        else
          res
          |> Absinthe.Resolution.put_result({:error, "unauthorized"})
        end
    end
  end
end
