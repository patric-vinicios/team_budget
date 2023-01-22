defmodule Graphql.Schema do
  use Absinthe.Schema

  alias Graphql.Resolvers
  alias Graphql.Middlewares

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
  end

  mutation do
    @desc "Create a new user"
    field :create_user, :user_payload do
      arg(:user, non_null(:user_input))
      resolve(&Resolvers.User.create_user/3)
      middleware(&build_payload/2)
    end

    @desc "Login with an user account"
    field :login, :login_payload do
      arg(:user, non_null(:login_input))
      resolve(&Resolvers.Session.login/3)
      middleware(&build_payload/2)
    end
  end
end
