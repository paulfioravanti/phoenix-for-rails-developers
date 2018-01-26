defmodule Storex.Accounts.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias Storex.Accounts.User
  alias Comeonin.Bcrypt

  schema "accounts_users" do
    field(:email, :string)
    field(:full_name, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:is_admin, :boolean)
    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :full_name, :password])
    |> validate_required([:email, :full_name, :password])
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  def admin_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:is_admin])
  end

  defp put_password_hash(%{valid?: true} = changeset) do
    password_hash =
      changeset
      |> get_change(:password)
      |> Bcrypt.add_hash()

    change(changeset, password_hash)
  end

  defp put_password_hash(changeset) do
    changeset
  end

  def check_password(user, password) do
    user
    |> Bcrypt.check_pass(password)
  end
end
