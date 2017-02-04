require 'spec_helper'

describe Money do

  describe '#add two numbers' do
    let(:money_1) { Money.new(3) }
    let(:money_2) { Money.new(2) }

    it 'add two moneys' do
      money_1 + money_2
      expect(money_1.amount).to eq 5
    end
    it 'restar two moneys' do
      total = money_1.amount - money_2.amount
      expect(total).to eq 1
    end

    it 'multiply two moneys' do
      total = money_1.amount * money_2.amount
      expect(total).to eq 6
    end

  end


end
