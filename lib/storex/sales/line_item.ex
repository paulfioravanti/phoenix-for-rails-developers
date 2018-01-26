defmodule Storex.Sales.LineItem do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias Storex.Sales.{Cart, LineItem, Order}
  alias Storex.Store.Book

  schema "sales_line_items" do
    belongs_to(:book, Book)
    belongs_to(:cart, Cart)
    belongs_to(:order, Order)
    field(:quantity, :integer)
    timestamps()
  end

  @doc false
  def changeset(%LineItem{} = line_item, attrs) do
    line_item
    |> cast(attrs, [:quantity])
    |> validate_required([:quantity])
  end
end
