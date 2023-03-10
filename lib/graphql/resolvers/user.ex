defmodule Graphql.Resolvers.User do
  alias TeamBudget.Accounts

  def list_users(_parent, _params, _resolutions) do
    {:ok, Accounts.list_users()}
  end

  def create_user(_, %{user: user}, _) do
    Accounts.create_user(user)
  end
end
