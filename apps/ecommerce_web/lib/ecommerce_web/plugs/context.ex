defmodule Ecommerce.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})

      _ ->
        conn
    end
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, current_user} <- authorize(token) do
      {:ok, %{current_user: current_user}}
    end
  end

  defp authorize(token) do
    case Ecommerce.Guardian.resource_from_token(token) do
      {:ok, current_user, _claims} ->
        {:ok, current_user}

      {:error, message} ->
        {:error, message}
    end
  end
end
