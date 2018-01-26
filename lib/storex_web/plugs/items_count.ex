defmodule StorexWeb.Plugs.ItemsCount do
  @moduledoc false

  import Plug.Conn
  alias Storex.Sales
  alias StorexWeb.Plugs
  alias Plugs.Cart, as: SessionCart

  @assign_name :items_count

  def init(opts), do: opts

  def call(conn, _opts) do
    quantity =
      conn
      |> SessionCart.get()
      |> Sales.list_line_items()
      |> Sales.line_items_quantity_count()

    assign(conn, @assign_name, quantity)
  end

  def get(conn) do
    conn.assigns[@assign_name]
  end
end
