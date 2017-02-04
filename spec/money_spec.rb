require 'spec_helper'

describe Money do

  describe '#add two numbers' do
    let(:money_1) { Money.new(3,'USD') }
    let(:money_2) { Money.new(2,'USD') }

    it 'sum two moneys' do
      new_money = money_1 + money_2
      expect(new_money.amount).to eq 5
      expect(new_money.currency.abbrev).to eq 'USD'
    end

    it 'substration moneys' do
      new_money = money_1 - money_2
      expect(new_money.amount).to eq 1
      expect(new_money.currency.abbrev).to eq 'USD'
    end

    it 'multiply two moneys' do
      new_money = money_1 * money_2
      expect(new_money.amount).to eq 6
      expect(new_money.currency.abbrev).to eq 'USD'
    end

    it 'divide two moneys' do
      new_money = money_1 * money_2
      expect(new_money.amount).to eq 6
      expect(new_money.currency.abbrev).to eq 'USD'
    end

  end


end
