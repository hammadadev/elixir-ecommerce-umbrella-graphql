defmodule EcommerceWeb.Schema.Query.UsersMutationTest do
  use EcommerceWeb.ConnCase, async: true

  @mutation """
  mutation CreateUser($createUser: UserInput!){
    user: createUser(input: $createUser){
      token
      user {
      firstName
      lastName
      email
      username
      id
      }
    }
  }
  """
  describe "new user registration" do
    test "user mutation returns new user data and token" do
      create_user = %{
        email: "test@example.com",
        firstName: "John",
        lastName: "Doe",
        password: "q1w2e3r4",
        telephone: "+923366767123",
        username: "john123"
      }

      conn = build_conn()
      conn = post conn, "/api", query: @mutation, variables: %{createUser: create_user}

      assert %{
               "user" => %{
                 "token" => _token,
                 "user" => %{
                   "email" => "test@example.com",
                   "firstName" => "John",
                   "lastName" => "Doe",
                   "username" => "john123"
                 }
               }
             } = json_response(conn, 200)["data"]
    end

    test "return unique constraint error for username" do
      insert(:user, username: "John321")

      create_user = %{
        email: "test@example.com",
        firstName: "John",
        lastName: "Doe",
        password: "q1w2e3r4",
        telephone: "+923366767123",
        username: "John321"
      }

      conn = build_conn()
      conn = post conn, "/api", query: @mutation, variables: %{createUser: create_user}

      assert %{
               "data" => %{"user" => nil},
               "errors" => [
                 %{
                   "key" => "username",
                   "message" => ["has already been taken"]
                 }
               ]
             } = json_response(conn, 200)
    end

    test "return unique constraint error for email" do
      insert(:user, email: "test@test.com")

      create_user = %{
        email: "test@test.com",
        firstName: "John",
        lastName: "Doe",
        password: "q1w2e3r4",
        telephone: "+923366767123",
        username: "John123"
      }

      conn = build_conn()
      conn = post conn, "/api", query: @mutation, variables: %{createUser: create_user}

      assert %{
               "data" => %{"user" => nil},
               "errors" => [
                 %{
                   "key" => "email",
                   "message" => ["has already been taken"]
                 }
               ]
             } = json_response(conn, 200)
    end

    test "return error for incorrect email format" do
      create_user = %{
        email: "test.com",
        firstName: "John",
        lastName: "Doe",
        password: "q1w2e3r4",
        telephone: "+923366767123",
        username: "John123"
      }

      conn = build_conn()
      conn = post conn, "/api", query: @mutation, variables: %{createUser: create_user}

      assert %{
               "data" => %{"user" => nil},
               "errors" => [
                 %{
                   "key" => "email",
                   "message" => ["has invalid format"]
                 }
               ]
             } = json_response(conn, 200)
    end

    test "return error when required fields are missing" do
      create_user = %{
        password: "q1w2e3r4",
        telephone: "+923366767123",
        username: "John123",
        role: "tech support"
      }

      conn = build_conn()
      conn = post conn, "/api", query: @mutation, variables: %{createUser: create_user}

      assert %{
               "errors" => [%{}]
             } = json_response(conn, 200)
    end
  end

  @mutation """
  mutation login($loginCredentials: LoginInput!){
    login(input: $loginCredentials) {
      token
      user{
        firstName
        username
        email
      }
    }
  }
  """
  describe "user login" do
    test "return token and user details on correct login" do
      user = insert(:user, email: "john@test.com")

      login_credentials = %{
        email: user.email,
        password: "q1w2e3r4"
      }

      conn = build_conn()

      conn =
        post conn, "/api", query: @mutation, variables: %{loginCredentials: login_credentials}

      assert %{
               "login" => %{
                 "token" => _token,
                 "user" => %{
                   "email" => "john@test.com"
                 }
               }
             } = json_response(conn, 200)["data"]
    end

    test "return error when email is incorrect" do
      insert(:user, email: "john@test.com")

      login_credentials = %{
        email: "test@test.com",
        password: "q1w2e3r4"
      }

      conn = build_conn()

      conn =
        post conn, "/api", query: @mutation, variables: %{loginCredentials: login_credentials}

      assert %{
               "data" => %{"login" => nil},
               "errors" => [
                 %{
                   "message" => "username or password is incorrect"
                 }
               ]
             } = json_response(conn, 200)
    end

    test "return error when password is incorrect" do
      user = insert(:user)

      login_credentials = %{
        email: user.email,
        password: "q1w2e3"
      }

      conn = build_conn()

      conn =
        post conn, "/api", query: @mutation, variables: %{loginCredentials: login_credentials}

      assert %{
               "data" => %{"login" => nil},
               "errors" => [
                 %{
                   "message" => "username or password is incorrect"
                 }
               ]
             } = json_response(conn, 200)
    end
  end
end
