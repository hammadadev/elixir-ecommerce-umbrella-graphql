defmodule Ecommerce.Users.User do
  use Schema

  schema "users" do
    field :username, :string
    field :email, :string
    field :first_name, :string
    field :password, :string, virtual: true
    field :password_hash, :string, redact: true
    field :last_name, :string
    field :telephone, :string
    field :role, :string, default: "customer"
    timestamps()
  end

  @required_attrs ~w(username email first_name password)a
  @optional_attrs ~w(last_name telephone password_hash)a
  def changeset(%__MODULE__{} = user, params \\ %{}) do
    user
    |> cast(params, @required_attrs ++ @optional_attrs)
    |> validate_required(@required_attrs)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_inclusion(:role, ["customer", "admin"])
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
