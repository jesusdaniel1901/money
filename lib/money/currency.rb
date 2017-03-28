require 'json'

class Currency
  attr_accessor :name,:symbol,:abbrev

  def initialize(currency_abbrev)
    currency = Bank.instance.get_currency(currency_abbrev.to_s.upcase)
    unless currency.nil?
      @name = currency["name"]
      @symbol = currency["symbol"]
      @abbrev = currency["abbrev"]
    else
      raise TypeError,"We do not support the currency #{currency_abbrev}"
    end

  end


end