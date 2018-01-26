defmodule StorexWeb.LayoutView do
  use StorexWeb, :view
  alias StorexWeb.Plugs.ItemsCount

  def items_count(conn) do
    ItemsCount.get(conn)
  end
end
