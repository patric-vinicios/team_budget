defmodule TeamBudget.Accounts do
  alias TeamBudget.Accounts.Core.UserRepo

  def list_users(), do: UserRepo.list_users()

  def create_user(user), do: UserRepo.create_user(user)
end
