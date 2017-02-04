require 'spec_helper'

describe Money do

  describe '#Arithmetics with USD' do
    let(:money_1) { Money.new(3,'USD') }
    let(:money_2) { Money.new(2,'USD') }

    it 'sum two moneys' do
      new_money = money_1 + money_2
      expect(new_money.amount).to eq 5
      expect(new_money.currency).to eq 'USD'
      expect(money_1 + money_2).to eq Money.new(5,'USD')
    end

    it 'substration moneys' do
      new_money = money_1 - money_2
      expect(new_money.amount).to eq 1
      expect(new_money.currency).to eq 'USD'
      expect(money_1 - money_2).to eq Money.new(1,'USD')
    end

    it 'multiply two moneys' do
      new_money = money_1 * money_2
      expect(new_money.amount).to eq 6
      expect(new_money.currency).to eq 'USD'
      expect(money_1 * money_2).to eq Money.new(6,'USD')
    end

    it 'divide two moneys' do
      new_money = money_1 / money_2
      expect(new_money.amount).to eq 1.5
      expect(new_money.currency).to eq 'USD'
      expect(money_1 / money_2).to eq Money.new(1.5,'USD')
    end

  end

  describe '#Arithmetics with USD and EUR' do
    let(:money_1) { Money.new(3,'EUR') }
    let(:money_2) { Money.new(2,'USD') }

    it 'sum two moneys' do
      new_money = money_1 + money_2
      expect(new_money.amount).to eq 4.84
      expect(new_money.currency).to eq 'EUR'
      expect(money_1 + money_2).to eq Money.new(4.84,'EUR')
    end

    it 'substration moneys' do
      new_money = money_1 - money_2
      expect(new_money.amount).to eq 1.16
      expect(new_money.currency).to eq 'EUR'
      expect(money_1 - money_2).to eq Money.new(1.16,'EUR')
    end

    it 'multiply two moneys' do
      new_money = money_1 * money_2
      expect(new_money.amount).to eq 5.52
      expect(new_money.currency).to eq 'EUR'
      expect(money_1 * money_2).to eq Money.new(5.52,'EUR')
    end

    it 'divide two moneys' do
      new_money = money_1 / money_2
      expect(new_money.amount).to eq 1.63
      expect(new_money.currency).to eq 'EUR'
      expect(money_1 / money_2).to eq Money.new(1.63,'EUR')
    end

  end

  describe '#convert_to' do

    let(:money_1) { Money.new(3,'USD') }

    it 'convert USD to EUR' do
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

  describe '#Comparisons' do
    let(:money_1) { Money.new(20,'USD') }
    let(:money_2) { Money.new(30,'EUR') }

    it 'compare USD with USD' do
      expect(money_1 == Money.new(20,'USD')).to eq true
    end

    it 'compare EUR with USD' do
      expect(money_1 < money_2).to eq true
      expect(money_2 > money_1 ).to eq true
    end

    it 'compare EUR with EUR' do
      expect(money_2 < Money.new(50,'EUR')).to eq true
      expect(money_2 > Money.new(10,'EUR') ).to eq true
    end

    it 'compare USD with GBP' do
      expect(money_1 < Money.new(20,'GBP')).to eq true
      expect(Money.new(20,'GBP') > Money.new(20,'EUR') ).to eq true
    end
  end

  describe 'conversion_rates' do
    it 'set the new EUR rates' do
      Money.conversion_rates('USD',{
        "EUR":10,
        "GBP": 20
      })
      currency_exchange_file = File.read('config/currencies_exchange.json')
      currency_exchange_json = JSON.parse currency_exchange_file
      expect(currency_exchange_json["USD"]["GBP"]).to eq 20
      expect(currency_exchange_json["USD"]["EUR"]).to eq 10
      Money.conversion_rates('USD',{
        "EUR":0.92,
        "GBP": 0.8
      })
    end
  end


end
