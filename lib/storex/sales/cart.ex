defmodule Storex.Sales.Cart do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias Storex.Sales.{Cart, LineItem}

  schema "sales_carts" do
    has_many(:line_items, LineItem)
    timestamps()
  end

  @doc false
  def changeset(%Cart{} = cart, attrs) do
    cart
    |> cast(attrs, [])
    |> validate_required([])
  end
end
