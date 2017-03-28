require "money/version"
require 'money/currency'
require 'money/bank'
require 'bigdecimal'

class Money
  attr_accessor :amount,:currency


  def initialize(amount,currency_string)
    @amount = BigDecimal.new(amount.to_s)
    @currency = Currency.new(currency_string)
  end

  def +(other_money)
    second_operand = validate_operand(other_money)
    new_result = make_operation(:+,@amount, second_operand.nil? ? other_money:second_operand)
    self.class.new(new_result,currency)
  end

  def -(other_money)
    second_operand = validate_operand(other_money)
    new_result = make_operation(:-,@amount,second_operand.nil? ? other_money:second_operand)
    self.class.new(new_result,currency)
  end

  def *(other_money)
    second_operand = validate_operand(other_money)
    new_result = make_operation(:*,@amount,second_operand.nil? ? other_money:second_operand)
    self.class.new(new_result,currency)
  end

  def /(other_money)
    second_operand = validate_operand(other_money)
    new_result = make_operation(:/,@amount,second_operand.nil? ? other_money:second_operand)
    !new_result.nil? ? self.class.new(new_result,currency) : division_error
  end

  def ==(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount_decimal
      @amount == second_operand
    else
      return type_error
    end
  end

  def >(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount_decimal
      @amount > second_operand
    else
      return type_error
    end
  end

  def <(other_money)
    if other_money.is_a?(Money)
      second_operand = other_money.convert_to(currency).amount_decimal
      @amount < second_operand
    else
      return type_error
    end
  end

  def currency
    @currency.abbrev
  end

  def inspect
    "#{@amount.to_s('F')} #{currency}"
  end

  def convert_to(currency_string)
    if @currency.abbrev.to_s == currency_string.to_s
      return self
    else
      currency_rate = Bank.instance.get_currency_rate(@currency.abbrev.to_s,currency_string.to_s)
      @amount = (@amount * BigDecimal.new(currency_rate.to_s)).round(2)
      @currency = Currency.new(currency_string)
      return self
    end
  end

  def self.conversion_rates(base_currency,options={})
    exchange_json_obj = Bank.instance.exchange_json
    exchange_json_obj[base_currency] = options
    begin
      File.open("config/currencies_exchange.json","w+") do |f|
        f.write(JSON.pretty_generate(exchange_json_obj))
      end
    rescue Exception => msg
      puts msg
    end
  end

  def amount
    BigDecimal(@amount.to_s('F'))
  end

  def amount_decimal
    @amount
  end

  private

  def make_operation(operator,operand_1,operand_2)
    case operator
      when :+
        new_result = operand_1 + BigDecimal.new(operand_2.to_s)
        return new_result
      when :-
        new_result = operand_1 - BigDecimal.new(operand_2.to_s)
        return new_result
      when :*
        new_result = (operand_1 * BigDecimal.new(operand_2.to_s)).round(2)
        return new_result
      when :/
        new_result = operand_2 !=0 ? (operand_1 / BigDecimal.new(operand_2.to_s)).round(2) : nil
        return new_result
    end
  end

  def type_error
    raise TypeError,'The type must be a number or Money'
  end

  def division_error
    raise ZeroDivisionError,'The division cannot be by 0'
  end

  def validate_operand(other_money)
    second_operand = other_money.convert_to(currency).amount_decimal if other_money.is_a?(Money)
    !other_money.is_a?(Numeric) && second_operand.nil? ? type_error : second_operand
  end

end