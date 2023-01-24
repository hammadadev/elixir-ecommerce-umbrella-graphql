defmodule EcommerceWeb.Schema.Query.UsersQueryTest do
  use EcommerceWeb.ConnCase, async: true

  setup do
    user = insert(:user)
    conn = auth_user(build_conn(), user)
    %{conn: conn, user: user}
  end

  @query """
  {
  user {
    firstName
    lastName
    email
    username
    telephone
  }
  }
  """

  describe "get current user details" do
    test "user field returns current user data", %{conn: conn, user: user} do
      conn = get conn, "/api", query: @query

      assert json_response(conn, 200) == %{
               "data" => %{
                 "user" => %{
                   "email" => user.email,
                   "firstName" => user.first_name,
                   "lastName" => user.last_name,
                   "telephone" => user.telephone,
                   "username" => user.username
                 }
               }
             }
    end

    test "return unauthorized error for invalid user" do
      conn = build_conn()
      conn = get conn, "/api", query: @query

      assert %{
               "errors" => [
                 %{
                   "message" => "unauthorized"
                 }
               ],
               "data" => %{"user" => nil}
             } = json_response(conn, 200)
    end
  end
end
