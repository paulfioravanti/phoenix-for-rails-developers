defmodule Storex.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Storex.Accounts.User

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

  defp put_password_hash(changeset = %{valid?: true}) do
    password_hash =
      changeset
      |> get_change(:password)
      |> Comeonin.Bcrypt.add_hash()

    change(changeset, password_hash)
  end

  defp put_password_hash(changeset) do
    changeset
  end

  def check_password(user, password) do
    user
    |> Comeonin.Bcrypt.check_pass(password)
  end
end
