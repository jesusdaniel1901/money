require "money/version"
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
      new_result  = @amount + second_operand
    elsif other_money.is_a?(Numeric)
      new_result  = @amount + other_money
    else
      raise TypeError
    end
    return self.class.new(new_result,currency)
  end

  def -(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount
      new_result  = @amount - second_operand
    elsif other_money.is_a?(Numeric)
      new_result = @amount - other_money
    else
      raise TypeError
    end
    return self.class.new(new_result,currency)
  end

  def *(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount
      new_result  = (@amount* second_operand).round(2)
    elsif other_money.is_a?(Numeric)
      new_result = (@amount * other_money).round(2)
    else
      raise TypeError
    end
    return self.class.new(new_result,currency)
  end

  def /(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount
      new_result  =  (@amount/second_operand.to_f).round(2) if second_operand != 0
    elsif other_money.is_a?(Numeric)
      new_result  = (@amount/other_money).round(2) if other_money != 0
    else
      raise TypeError
    end
    return self.class.new(new_result,currency)
  end

  def ==(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount
      @amount == second_operand ? true : false
    else
      raise TypeError
    end
  end

  def >(other_money)
    if other_money.money?
      second_operand = other_money.convert_to(currency).amount
      @amount > second_operand ? true: false
    else
      raise TypeError
    end
  end

  def <(other_money)
    if other_money.money?
      second_operand = other_money.convert_to(currency).amount
      @amount < second_operand ? true: false
    else
      raise TypeError
    end
  end

  def currency
    @currency.abbrev
  end

  def inspect
    "#{amount} #{currency}"
  end

  def convert_to(currency_string)
    if @currency.abbrev.to_s == currency_string.to_s
      return self
    else
      file = File.read('config/currencies_exchange.json')
      data_hash = JSON.parse(file)
      currency_rate =  data_hash[@currency.abbrev.to_s][currency_string.to_s]
      @amount = (@amount *currency_rate).round(2)
      @currency = Currency.new(currency_string)
      return self
    end
  end

  def self.conversion_rates(base_currency,options={})
    currency_exchange_file = File.read('config/currencies_exchange.json')
    currency_exchange_json = JSON.parse currency_exchange_file
    currency_exchange_json[base_currency]= options

    File.open("config/currencies_exchange.json","w+") do |f|
      f.write(JSON.pretty_generate(currency_exchange_json))
    end
  end



  def money?
    is_a?(Money)
  end





end

