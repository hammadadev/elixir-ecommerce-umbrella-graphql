defmodule EcommerceWeb.Test.Support.LoginUser do
  import Plug.Conn

  def auth_user(conn, user) do
    {:ok, token, _claims} = Ecommerce.Guardian.encode_and_sign(user)
    put_req_header(conn, "authorization", "Bearer #{token}")
  end
end
