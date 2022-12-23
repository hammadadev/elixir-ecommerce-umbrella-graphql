defmodule Schema do
  defmacro __using__(_options) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
    end
  end
end
