defmodule Ecommerce.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Ecommerce.Repo
  alias Ecommerce.Users.User

  def user_factory do
    %User{
      first_name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name(),
      username: Faker.Person.name(),
      email: sequence(:email, &"email-#{&1}@example.com"),
      telephone: Faker.Phone.PtBr.phone(),
      password_hash: Bcrypt.Base.hash_password("q1w2e3r4", Bcrypt.Base.gen_salt(12, true)),
      password: "q1w2e3r4",
      role: sequence(:role, ["admin", "customer"])
    }
  end
end
