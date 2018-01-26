defmodule StorexWeb.CartController do
  use StorexWeb, :controller
  alias Storex.{Store, Sales}
  alias StorexWeb.Plugs
  alias Plugs.Cart, as: SessionCart

  def show(conn, _params) do
    items =
      conn
      |> SessionCart.get()
      |> Sales.list_line_items()

    total = Sales.line_items_total_price(items)
    render(conn, "show.html", items: items, total: total)
  end

  def create(conn, %{"book_id" => book_id}) do
    cart = SessionCart.get(conn)

    book_id
    |> Store.get_book()
    |> Sales.add_book_to_cart(cart)

    redirect(conn, to: cart_path(conn, :show))
  end

  def delete(conn, %{"book_id" => book_id}) do
    cart = SessionCart.get(conn)

    book_id
    |> Store.get_book()
    |> Sales.remove_book_from_cart(cart)

    redirect(conn, to: cart_path(conn, :show))
  end
end
