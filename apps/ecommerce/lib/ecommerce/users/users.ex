defmodule Ecommerce.Users.Users do
  alias Ecommerce.Users.User
  alias Ecommerce.Repo

  def find_user(id) do
    case Repo.get(User, id) do
      nil ->
        nil

      user ->
        user
    end
  end

  def create_user(params) do
    changeset = User.changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        {:ok, token, _claims} = Ecommerce.Guardian.encode_and_sign(user)
        {:ok, %{token: token, user: user}}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def validate_user(params) do
    with %User{} = user <- find_user_by_email(params.email),
         {:ok, _} <- verify_user_password(params.password, user.password_hash) do
      {:ok, token, _claims} = Ecommerce.Guardian.encode_and_sign(user)
      {:ok, %{token: token, user: user}}
    else
      _ ->
        {:error, "Username or password is incorrect"}
    end
  end

  def find_user_by_email(email), do: Repo.get_by(User, email: email)

  def verify_user_password(password, password_hash) do
    case Bcrypt.verify_pass(password, password_hash) do
      false ->
        {:error, "invalid password"}

      true ->
        {:ok, "Correct password"}
    end
  end
end
