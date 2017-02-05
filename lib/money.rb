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
    second_operand = validate_operand(other_money)
    new_result = make_operation(:+,@amount,other_money.is_a?(Money)? second_operand:other_money)
    self.class.new(new_result,currency)
  end

  def -(other_money)
    second_operand = validate_operand(other_money)
    new_result = make_operation(:-,@amount,other_money.is_a?(Money)? second_operand:other_money)
    self.class.new(new_result,currency)
  end

  def *(other_money)
    second_operand = validate_operand(other_money)
    new_result = make_operation(:*,@amount,other_money.is_a?(Money)? second_operand:other_money)
    self.class.new(new_result,currency)
  end

  def /(other_money)
    second_operand = validate_operand(other_money)
    new_result = make_operation(:/,@amount,other_money.is_a?(Money)? second_operand:other_money)
    !new_result.nil? ? self.class.new(new_result,currency) : division_error
  end

  def ==(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount
      @amount == second_operand
    else
      return type_error
    end
  end

  def >(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount
      @amount > second_operand
    else
      return type_error
    end
  end

  def <(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount
      @amount < second_operand
    else
      return type_error
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

  private

  def make_operation(operator,operand_1,operand_2)
    case operator
      when :+
        new_result = operand_1 + operand_2
        return new_result
      when :-
        new_result = operand_1 - operand_2
        return new_result
      when :*
        new_result = (operand_1 * operand_2).round(2)
        return new_result
      when :/
        new_result = operand_2 !=0 ? (operand_1 / operand_2.to_f).round(2) : nil
        return new_result
    end
  end


  def type_error
    raise TypeError,'The type must be a number or Money'
  end

  def division_error
    raise   ZeroDivisionError, 'The division cannot be by 0'
  end

  def validate_operand(other_money)
    second_operand = other_money.convert_to(currency).amount if other_money.is_a?(Money)
    !other_money.is_a?(Numeric) && second_operand.nil? ? type_error : second_operand
  end

end

