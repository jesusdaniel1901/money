require 'json'
class Currency
  attr_accessor :name,:symbol,:abbrev

  def initialize(currency_abbrev)
    currency = look_in_json_file(currency_abbrev.to_s.upcase)
    @name = currency["name"]
    @symbol = currency["symbol"]
    @abbrev = currency["abbrev"]
  end

  def look_in_json_file(currency_abbrev)
    file = File.read('config/moneys.json')
    data_hash = JSON.parse(file)
    return data_hash[currency_abbrev]
  end

end