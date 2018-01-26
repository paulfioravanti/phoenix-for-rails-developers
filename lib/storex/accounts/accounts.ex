defmodule Storex.Accounts do
  @moduledoc false

  import Ecto.Query, warn: false
  alias Storex.Repo
  alias Storex.Accounts.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user!(id) do
    User
    |> Repo.get!(id)
  end

  def new_user do
    %User{}
    |> User.changeset(%{})
  end

  def authenticate_user(email, password) do
    User
    |> Repo.get_by(email: email)
    |> User.check_password(password)
  end

  def mark_as_admin(user) do
    user
    |> User.admin_changeset(%{is_admin: true})
    |> Repo.update()
  end
end
