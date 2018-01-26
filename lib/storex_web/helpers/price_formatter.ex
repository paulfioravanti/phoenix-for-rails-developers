defmodule StorexWeb.Helpers.PriceFormatter do
  @moduledoc false

  alias Number.Currency

  def format_price(%Decimal{} = price) do
    price
    |> Currency.number_to_currency()
  end
end
