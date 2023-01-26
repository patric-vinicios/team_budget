defmodule TeamBudget.Teams.Core.TeamRepo do
    import Ecto.Query
    alias TeamBudget.Teams.Data.Team
    alias TeamBudget.Repo

    def list_teams(user_id) do
        query =
            from team in Team, where: team.user_id == ^user_id

        Repo.all(query)
    end

end