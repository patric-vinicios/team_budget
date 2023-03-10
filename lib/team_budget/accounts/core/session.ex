defmodule TeamBudget.Accounts.Core.Session do
  alias TeamBudget.Accounts.Core.UserRepo
  alias TeamBudget.Accounts.Core.Guardian

  def login(user) do
    with {:ok, user} <- authenticate(user), {:ok, token, _} <- Guardian.sign(user) do
      {:ok, %{token: token, user: user}}
    end
  end

  defp authenticate(user) do
    case UserRepo.get_by_email(user.email) do
      nil ->
        {:error, "Incorrect login credentials"}

      user_to_authenticate ->
        if Argon2.verify_pass(user.password, user_to_authenticate.password_hash) do
          {:ok, user_to_authenticate}
        else
          {:error, :unauthorized}
        end
    end
  end
end
