require 'singleton'

class Bank
  include Singleton

  attr_accessor :money_json,:exchange_json

  def initialize
    begin
      @money_json = JSON.parse(File.read('config/moneys.json'))
      @exchange_json = JSON.parse(File.read('config/currencies_exchange.json'))
    rescue Exception => msg
      puts msg
    end
  end

  def get_currency(currency_abbrev)
    @money_json[currency_abbrev]
  end

  def get_currency_rate(currency_abbrev,currency_string)
    @exchange_json[currency_abbrev][currency_string]
  end

end