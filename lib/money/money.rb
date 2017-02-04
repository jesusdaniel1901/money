require 'money/currency'
class Money
  attr_accessor :amount,:currency

  extend Enumerable

  def initialize(amount,currency_string)
    @amount = amount
    @currency = Currency.new(currency_string)
  end

  def +(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount
      @amount  +=  second_operand
    elsif other_money.is_a?(Numeric)
      @amount  +=  other_money
    else
      raise TypeError
    end
    return self
  end

  def -(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount
      @amount  -= second_operand
    elsif other_money.is_a?(Numeric)
      @amount -= other_money
    else
      raise TypeError
    end
    return self
  end

  def *(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount
      @amount  = (@amount* second_operand).round(2)
    elsif other_money.is_a?(Numeric)
      @amount -= other_money
    else
      raise TypeError
    end
    return self
  end

  def /(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount
      @amount  =  (@amount/second_operand).round(2) if second_operand != 0
    elsif other_money.is_a?(Numeric)
      @amount  = (@amount/other_money).round(2) if other_money != 0
    else
      raise TypeError
    end
    return self
  end

  def currency
    @currency.abbrev
  end

  def inspect
    "#{amount} #{currency}"
  end

  def convert_to(currency_string)
    file = File.read('config/currencies_exchange.json')
    data_hash = JSON.parse(file)
    currency_rate =  data_hash[@currency.abbrev.to_s][currency_string.to_s]
    @amount = (@amount *currency_rate).round(2)
    @currency = Currency.new(currency_string)
    return self
  end

  def self.conversion_rates(base_currency,options={})
    file = File.read('config/currencies_exchange.json')
    hash = JSON.parse file
    hash[base_currency]= options
    hash.to_json
    JSON.pretty_generate hash

    File.open("config/currencies_exchange.json","w") do |f|
      f.write(JSON.pretty_generate(hash))
    end
  end





end