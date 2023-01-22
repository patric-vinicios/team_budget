# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TeamBudget.Repo.insert!(%TeamBudget.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TeamBudget.{Accounts.User, Repo}

%{
  first_name: "Patric",
  last_name: "Vinicios",
  email: "psdev7@gmail.com",
  password: "123456",
  password_confirmation: "123456"
}
|> User.changeset()
|> Repo.insert()

%{
  first_name: "Sherlock",
  last_name: "Holmes",
  email: "sherlock_holmes@gmail.com",
  password: "123456",
  password_confirmation: "123456"
}
|> User.changeset()
|> Repo.insert()
