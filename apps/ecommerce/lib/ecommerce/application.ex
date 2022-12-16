defmodule Ecommerce.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Ecommerce.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ecommerce.PubSub}
      # Start a worker by calling: Ecommerce.Worker.start_link(arg)
      # {Ecommerce.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Ecommerce.Supervisor)
  end
end
