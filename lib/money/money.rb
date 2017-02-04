class Money
  attr_accessor :amount

  def initialize(amount)
    @amount = amount
  end

  # [:+, :-].each do |op|
  #   define_method(op) do |other|
  #     unless other.is_a?(Money)
  #       return self if other.zero?
  #       raise TypeError
  #     end
  #     other = other.exchange_to(currency)
  #     self.class.new(fractional.public_send(op, other.fractional), currency)
  #   end
  # end

  def +(other_money)
    @amount  +=  other_money.amount
  end

end