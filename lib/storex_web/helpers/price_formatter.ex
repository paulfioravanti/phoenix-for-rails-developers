defmodule StorexWeb.Helpers.PriceFormatter do
  @moduledoc false

  alias Number.Currency

  def format_price(%Decimal{} = price) do
    Currency.number_to_currency(price)
  end
end
