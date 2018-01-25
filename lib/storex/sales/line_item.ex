defmodule Storex.Sales.LineItem do
  use Ecto.Schema
  import Ecto.Changeset
  alias Storex.Sales.{Cart, LineItem}
  alias Storex.Store.Book

  schema "sales_line_items" do
    belongs_to(:cart, Cart)
    belongs_to(:book, Book)
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
