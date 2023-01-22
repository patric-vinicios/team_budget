defmodule Graphql.Resolvers.Session do
  alias TeamBudget.Session

  def login(_, %{user: user}, _) do
    Session.login(user)
  end
end
