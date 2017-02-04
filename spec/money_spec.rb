require 'spec_helper'

describe Money do

  describe '#operands' do
    let(:money_1) { Money.new(3,'USD') }
    let(:money_2) { Money.new(2,'USD') }

    it 'sum two moneys' do
      new_money = money_1 + money_2
      expect(new_money.amount).to eq 5
      expect(new_money.currency).to eq 'USD'
    end

    it 'substration moneys' do
      new_money = money_1 - money_2
      expect(new_money.amount).to eq 1
      expect(new_money.currency).to eq 'USD'
    end

    it 'multiply two moneys' do
      new_money = money_1 * money_2
      expect(new_money.amount).to eq 6
      expect(new_money.currency).to eq 'USD'
    end

    it 'divide two moneys' do
      new_money = money_1 * money_2
      expect(new_money.amount).to eq 6
      expect(new_money.currency).to eq 'USD'
    end

  end

  describe '#operands_with_two_money' do
    let(:money_1) { Money.new(3,'EUR') }
    let(:money_2) { Money.new(2,'USD') }

    it 'sum two moneys' do
      new_money = money_1 + money_2
      expect(new_money.amount).to eq 4.84
      expect(new_money.currency).to eq 'EUR'
    end

    it 'substration moneys' do
      new_money = money_1 - money_2
      expect(new_money.amount).to eq 1.16
      expect(new_money.currency).to eq 'EUR'
    end

    it 'multiply two moneys' do
      new_money = money_1 * money_2
      expect(new_money.amount).to eq 5.52
      expect(new_money.currency).to eq 'EUR'
    end

    it 'divide two moneys' do
      new_money = money_1 / money_2
      expect(new_money.amount).to eq 1.63
      expect(new_money.currency).to eq 'EUR'
    end

  end

  describe '#convert' do

    let(:money_1) { Money.new(3,'USD') }

    it 'convert  to euro' do
      money_1.convert_to('EUR')
      expect(money_1.currency).to eq 'EUR'
      expect(money_1.amount).to eq 2.76
    end

    it 'convert  to GBP' do
      money_1.convert_to('GBP')
      expect(money_1.currency).to eq 'GBP'
      expect(money_1.amount).to eq 2.4
    end

  end


end
