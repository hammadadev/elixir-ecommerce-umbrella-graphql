defmodule Ecommerce.Users.User do
  use Schema

  schema "users" do
    field :username, :string
    field :email, :string
    field :first_name, :string
    field :password, :string, redact: true
    field :last_name, :string
    field :telephone, :integer
  end

  @required_attrs ~w(username email first_name password)a
  @optional_attrs ~w(last_name telephone)a
  def changeset(%__MODULE__{} = user, params \\ %{}) do
    user
    |> cast(params, @required_attrs ++ @optional_attrs)
    |> validate_required(@required_attrs)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
