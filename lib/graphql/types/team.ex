defmodule Graphql.Types.Team do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias TeamBudget.Teams.Data.Team

  object :team do
    field :id, :string
    field :name, :string
    field :description, :string
    field :slug, :string
    field :user_id, :string

    field :user, :user do
      resolve(dataloader(Team))
    end
  end

  input_object :team_input do
    field :name, :string
    field :description, :string
  end
end
