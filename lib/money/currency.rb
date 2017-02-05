require 'json'
class Currency
  attr_accessor :name,:symbol,:abbrev

  def initialize(currency_abbrev)
    currency = look_in_json_file(currency_abbrev.to_s.upcase)
    unless currency.nil?
      @name = currency["name"]
      @symbol = currency["symbol"]
      @abbrev = currency["abbrev"]
    else
      raise TypeError,"We do not support the currency #{currency_abbrev}"
    end

  end

  def look_in_json_file(currency_abbrev)
    money_file = File.read('config/moneys.json')
    currency_json = JSON.parse(money_file)
    return currency_json[currency_abbrev]
  end

end