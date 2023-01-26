defmodule TeamBudget.Teams.Data.Team do
  use Ecto.Schema
  import Ecto.Changeset

  alias TeamBudget.Util.CreateSlug
  alias TeamBudget.Accounts.Data.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teams" do
    field :description, :string
    field :name, :string
    field :slug, :string

    belongs_to :user, User

    timestamps()
  end

  def data, do: Dataloader.Ecto.new(TeamBudget.Repo, query: &query/2)

  def query(queryable, _params), do: queryable

  def changeset(attrs \\ %{}) do
    changeset(%__MODULE__{}, attrs)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :slug, :description, :user_id])
    |> validate_required([:name, :description])
    |> CreateSlug.perform(:name)
    |> unique_constraint(:slug)
    |> unique_constraint(:name)
  end

end
