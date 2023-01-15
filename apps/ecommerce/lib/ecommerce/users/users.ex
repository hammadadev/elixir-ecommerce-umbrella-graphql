defmodule Ecommerce.Users.Users do
  alias Ecommerce.Users.User
  alias Ecommerce.Repo

  def find_user(id) do
    case Repo.get(User, id) do
      nil ->
        {:error, "user not found"}

      user ->
        user
    end
  end

  def create_user(params) do
    changeset = User.changeset(%User{}, params)

    with {:ok, user} <- Repo.insert(changeset),
         {:ok, token, _claims} <- Ecommerce.Guardian.encode_and_sign(user) do
      {:ok, %{token: token, user: user}}
    end
  end

  def user_login(params) do
    with %User{} = user <- find_user_by_email(params.email),
         true <- verify_user_password(params.password, user.password_hash) do
      {:ok, token, _claims} = Ecommerce.Guardian.encode_and_sign(user)
      {:ok, %{token: token, user: user}}
    else
      _ ->
        {:error, "username or password is incorrect"}
    end
  end

  def find_user_by_email(email), do: Repo.get_by(User, email: email)

  def verify_user_password(password, password_hash),
    do: Bcrypt.verify_pass(password, password_hash)
end
