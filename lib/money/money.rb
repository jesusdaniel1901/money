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
      @amount  +=  other_money.amount
    elsif other_money.is_a?(Numeric)
      @amount  +=  other_money
    else
      raise TypeError
    end
    return self
  end

  def -(other_money)
    if other_money.is_a?(Money)
      @amount  -=  other_money.amount
    elsif other_money.is_a?(Numeric)
      @amount -= other_money
    else
      raise TypeError
    end
    return self
  end

  def *(other_money)
    if other_money.is_a?(Money)
      @amount  *=  other_money.amount
    elsif other_money.is_a?(Numeric)
      @amount -= other_money
    else
      raise TypeError
    end
    return self
  end

  def /(other_money)
    if other_money.is_a?(Money)
      @amount  /=  other_money.amount if other_money.amount != 0
    elsif other_money.is_a?(Numeric)
      @amount  /=  other_money if other_money != 0
    else
      raise TypeError
    end
    return self
  end

  def currency
    @currency
  end





end