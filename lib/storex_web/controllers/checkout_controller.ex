defmodule StorexWeb.CheckoutController do
  use StorexWeb, :controller
  alias Storex.Sales
  alias StorexWeb.Plugs
  alias Plugs.Cart, as: SessionCart
  alias Plugs.CurrentUser

  plug :ensure_current_user

  def new(conn, _params) do
    changeset = Sales.new_order()

    conn
    |> with_cart_information()
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"order" => order_params}) do
    cart = SessionCart.get(conn)
    user = CurrentUser.get(conn)

    case Sales.process_order(user, cart, order_params) do
      {:ok, _order} ->
        conn
        |> put_flash(:info, "Order successfuly created. Thanks!")
        |> SessionCart.forget()
        |> redirect(to: book_path(conn, :index))

      {:error, changeset} ->
        conn
        |> with_cart_information()
        |> render("new.html", changeset: changeset)
    end
  end

  defp ensure_current_user(conn, _opts) do
    if CurrentUser.get(conn) do
      conn
    else
      conn
      |> put_flash(:error, "Sign in or Sign up before you continue")
      |> redirect(to: user_path(conn, :new))
      |> halt()
    end
  end

  defp with_cart_information(conn) do
    items =
      conn
      |> SessionCart.get()
      |> Sales.list_line_items()

    items_count = Sales.line_items_quantity_count(items)
    total_price = Sales.line_items_total_price(items)

    conn
    |> assign(:items_count, items_count)
    |> assign(:total_price, total_price)
  end
end
