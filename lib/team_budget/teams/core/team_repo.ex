defmodule TeamBudget.Teams.Core.TeamRepo do
  import Ecto.Query
  alias TeamBudget.Teams.Data.Team
  alias TeamBudget.Repo

  def list_teams(user_id) do
    query = from team in Team, where: team.user_id == ^user_id

    Repo.all(query)
  end

  def get_team_by_user_and_slug(user_id, slug) do
    Repo.get_by(Team, slug: slug, user_id: user_id)
  end

end
