defmodule Graphql.Schema do
  use Absinthe.Schema

  alias Graphql.Resolvers
  alias Graphql.Middlewares
  alias TeamBudget.Teams.Data.Team

  import_types(Graphql.Types)

  import AbsintheErrorPayload.Payload
  import_types(AbsintheErrorPayload.ValidationMessageTypes)

  payload_object(:user_payload, :user)
  payload_object(:login_payload, :session)

  query do
    @desc "Get list of all users"
    field :list_users, list_of(:user) do
      middleware(Middlewares.Authorize, :user)
      resolve(&Resolvers.User.list_users/3)
    end

    @desc "Get list of all teams from an user"
    field :list_teams, list_of(:team) do
      middleware(Middlewares.Authorize, :user)
      resolve(&Resolvers.Team.list_teams/3)
    end
  end

  mutation do
    @desc "Create a new user"
    field :create_user, :user_payload do
      arg(:user, non_null(:user_input))
      resolve(&Resolvers.User.create_user/3)
      middleware(&build_payload/2)
    end

    @desc "Send an invite"
    field :send_invite, list_of(:string) do
      arg(:invites, non_null(list_of(:string)))
      middleware(Middleware.Authorize, :user)
      middleware(Middleware.SetAteam)
      resolve(&Resolvers.Invite.send_invite/2)
    end

    @desc "Login with an user account"
    field :login, :login_payload do
      arg(:user, non_null(:login_input))
      resolve(&Resolvers.Session.login/3)
      middleware(&build_payload/2)
    end
  end

  def context(context) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Team, Team.data())

    Map.put(context, :loader, loader)
  end

  def plugins, do: [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
end
