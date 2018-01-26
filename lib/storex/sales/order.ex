defmodule Storex.Sales.Order do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias Storex.Sales.{LineItem, Order}
  alias Storex.Accounts.User

  schema "sales_orders" do
    field(:address, :string)
    belongs_to(:user, User)
    has_many(:line_items, LineItem)
    timestamps()
  end

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, [:address])
    |> validate_required([:address])
  end
end
