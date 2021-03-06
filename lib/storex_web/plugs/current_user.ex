defmodule StorexWeb.Plugs.CurrentUser do
  @moduledoc false

  import Plug.Conn
  alias Storex.Accounts

  @session_name :user_id
  @assign_name :current_user

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, @session_name)

    if user = user_id && Accounts.get_user!(user_id) do
      assign_user(conn, user)
    else
      assign_user(conn, nil)
    end
  end

  def assign_user(conn, user) do
    conn
    |> assign(@assign_name, user)
    |> assign(:is_admin, is_admin?(user))
  end

  def is_admin?(%Plug.Conn{} = conn) do
    user = get(conn)
    is_admin?(user)
  end

  def is_admin?(user) do
    user && user.is_admin
  end

  def set(conn, user) do
    conn
    |> put_session(@session_name, user.id)
    |> assign_user(user)
  end

  def get(conn), do: conn.assigns[@assign_name]
end
