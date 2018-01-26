defmodule StorexWeb.UserController do
  use StorexWeb, :controller
  alias Storex.Accounts
  alias StorexWeb.Plugs.CurrentUser

  def new(conn, _params) do
    render(conn, "new.html", changeset: Accounts.new_user())
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> CurrentUser.set(user)
        |> redirect(to: cart_path(conn, :show))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
