require 'json'
class Currency
  attr_accessor :name,:symbol,:abbrev

  def initialize(currency_abbrev)
    currency = look_in_json_file(currency_abbrev.to_s.upcase)
    unless currency.nil?
      @name = currency["name"]
      @symbol = currency["symbol"]
      @abbrev = currency["abbrev"]
    end
  end

  def look_in_json_file(currency_abbrev)
    file = File.read('config/moneys.json')
    data_hash = JSON.parse(file)
    data_hash["currencies"].each do |currency|
      if currency["abbrev"] == currency_abbrev
        return currency
      end
    end
    return nil
  end

end