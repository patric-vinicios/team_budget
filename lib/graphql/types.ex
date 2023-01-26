defmodule Graphql.Types do
  use Absinthe.Schema.Notation
  alias Graphql.Types
  import_types(Types.Session)
  import_types(Types.Team)
  import_types(Types.User)
end
