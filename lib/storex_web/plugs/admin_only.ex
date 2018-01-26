defmodule StorexWeb.Plugs.AdminOnly do
  @moduledoc false

  import Plug.Conn
  alias StorexWeb.Plugs
  alias Plugs.CurrentUser

  def init(opts), do: opts

  def call(conn, _opts) do
    if CurrentUser.is_admin?(conn) do
      conn
    else
      conn
      |> put_resp_content_type("text/plain")
      |> send_resp(:forbidden, "forbidden")
      |> halt()
    end
  end
end
