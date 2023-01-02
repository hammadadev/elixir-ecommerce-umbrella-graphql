defmodule Ecommerce.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    execute("create type role_type as enum ('admin', 'customer')", "drop type role_type")

    create table(:users) do
      add(:username, :string, null: false)
      add(:email, :string, null: false)
      add(:first_name, :string, null: false)
      add(:password, :string, null: false)
      add(:last_name, :string)
      add(:telephone, :string)
      add(:role, :role_type, default: "customer")
      timestamps()
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
  end
end
