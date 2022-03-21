# frozen_string_literal: true

module PrettyMoney
  def pretty_format_money(obj)
    ActiveSupport::NumberHelper.number_to_currency(
      ActiveSupport::NumberHelper.number_to_delimited(obj),
      precision: 0).presence || '-'
  end
end
