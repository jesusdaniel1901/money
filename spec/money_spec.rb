require 'spec_helper'

describe Money do

  describe '#Constructors' do
    let(:thirty_eur) { Money.new(30,'EUR') }

    it 'test the instance methods' do
      expect(thirty_eur.amount).to eq 30
      expect(thirty_eur.currency).to eq 'EUR'
      expect(thirty_eur.inspect).to eq '30.0 EUR'
    end

    it 'tries to create an invalid money' do
       expect { Money.new('30','Bitcoin') }.to raise_error(TypeError,'We do not support the currency Bitcoin')
    end

  end

  describe '#Arithmetics with USD' do
    let(:thirty_usd) { Money.new(30,'USD') }
    let(:twenty_usd) { Money.new(20,'USD') }

    it 'sum two moneys' do
      new_money = thirty_usd + twenty_usd
      expect(new_money.amount).to eq 50
      expect(new_money.currency).to eq 'USD'
      expect(thirty_usd + twenty_usd).to eq Money.new(50,'USD')
    end

    it 'sum two moneys and second operand is a number' do
      new_money = thirty_usd + 10
      expect(new_money.amount).to eq 40
      expect(new_money.currency).to eq 'USD'
      expect(thirty_usd + 10).to eq Money.new(40,'USD')
    end

    it 'subtracts moneys' do
      new_money = thirty_usd - twenty_usd
      expect(new_money.amount).to eq 10
      expect(new_money.currency).to eq 'USD'
      expect(thirty_usd - twenty_usd).to eq Money.new(10,'USD')
    end

    it 'subtract two moneys and second operand is a number' do
      new_money = thirty_usd - 10
      expect(new_money.amount).to eq 20
      expect(new_money.currency).to eq 'USD'
      expect(thirty_usd - 10).to eq Money.new(20,'USD')
    end

    it 'multiplies two moneys' do
      new_money = thirty_usd * twenty_usd
      expect(new_money.amount).to eq 600
      expect(new_money.currency).to eq 'USD'
      expect(thirty_usd * twenty_usd).to eq Money.new(600,'USD')
    end

    it 'multiplies two moneys and second operand is a number' do
      new_money = thirty_usd * 3
      expect(new_money.amount).to eq 90.0
      expect(new_money.currency).to eq 'USD'
      expect(thirty_usd * 3).to eq Money.new(90.0,'USD')
    end

    it 'divides two moneys' do
      new_money = thirty_usd / twenty_usd
      expect(new_money.amount).to eq 1.5
      expect(new_money.currency).to eq 'USD'
      expect(thirty_usd / twenty_usd).to eq Money.new(1.5,'USD')
    end

    it 'divides two moneys and second operand is a number' do
      new_money = thirty_usd / 3
      expect(new_money.amount).to eq 10.0
      expect(new_money.currency).to eq 'USD'
      expect(thirty_usd / 3).to eq Money.new(10.0,'USD')
    end

  end

  describe '#Arithmetics with USD and EUR' do
    let(:thirty_eur) { Money.new(30,'EUR') }
    let(:twenty_usd) { Money.new(20,'USD') }

    it 'sum two moneys' do
      new_money = thirty_eur + twenty_usd
      expect(new_money.amount).to eq 48.4
      expect(new_money.currency).to eq 'EUR'
      expect(thirty_eur + twenty_usd).to eq Money.new(48.4,'EUR')
    end

    it 'substration moneys' do
      new_money = thirty_eur - twenty_usd
      expect(new_money.amount).to eq 11.6
      expect(new_money.currency).to eq 'EUR'
      expect(thirty_eur - twenty_usd).to eq Money.new(11.6,'EUR')
    end

    it 'multiply two moneys' do
      new_money = thirty_eur * twenty_usd
      expect(new_money.amount).to eq 552.0
      expect(new_money.currency).to eq 'EUR'
      expect(thirty_eur * twenty_usd).to eq Money.new(552.0,'EUR')
    end

    it 'divide two moneys' do
      new_money = thirty_eur / twenty_usd
      expect(new_money.amount).to eq 1.63
      expect(new_money.currency).to eq 'EUR'
      expect(thirty_eur / twenty_usd).to eq Money.new(1.63,'EUR')
    end

  end

  describe '#convert_to' do

    let(:thirty_usd) { Money.new(30,'USD') }
    let(:twenty_eur) { Money.new(20,'EUR') }

    it 'convert USD to EUR' do
      thirty_usd.convert_to('EUR')
      expect(thirty_usd.currency).to eq 'EUR'
      expect(thirty_usd.amount).to eq 27.6
      expect(thirty_usd).to eq Money.new(27.6,'EUR')
    end

    it 'convert USD to GBP' do
      thirty_usd.convert_to('GBP')
      expect(thirty_usd.currency).to eq 'GBP'
      expect(thirty_usd.amount).to eq 24.0
      expect(thirty_usd).to eq Money.new(24.0,'GBP')
    end

    it 'convert EUR to GBP' do
      twenty_eur.convert_to('GBP')
      expect(twenty_eur.currency).to eq 'GBP'
      expect(twenty_eur.amount).to eq 17.2
      expect(twenty_eur).to eq Money.new(17.2,'GBP')
    end

    it 'convert EUR to USD' do
      twenty_eur.convert_to('USD')
      expect(twenty_eur.currency).to eq 'USD'
      expect(twenty_eur.amount).to eq 21.6
      expect(twenty_eur).to eq Money.new(21.6,'USD')
    end

  end

  describe '#Comparisons' do
    let(:thirty_eur) { Money.new(30,'EUR') }
    let(:twenty_usd) { Money.new(20,'USD') }

    it 'compare USD with USD' do
      expect(thirty_eur == Money.new(30,'EUR')).to eq true
      expect(thirty_eur == Money.new(20,'EUR')).to eq false
    end

    it 'compare EUR with USD' do
      expect(thirty_eur > twenty_usd).to eq true
      expect(twenty_usd < thirty_eur ).to eq true
    end

    it 'compare EUR with EUR' do
      expect(twenty_usd < Money.new(50,'EUR')).to eq true
      expect(twenty_usd > Money.new(10,'EUR') ).to eq true
    end

    it 'compare USD with GBP' do
      expect(twenty_usd < Money.new(20,'GBP')).to eq true
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

  describe '#errors' do

    let(:thirty_eur) { Money.new(30,'EUR') }

    it 'test the Arithmetics operands and raise a type error' do
      expect { thirty_eur + 'jesus' }.to raise_error(TypeError,'The type must be a number or Money')
      expect { thirty_eur - 'jesus' }.to raise_error(TypeError,'The type must be a number or Money')
      expect { thirty_eur * 'jesus' }.to raise_error(TypeError,'The type must be a number or Money')
      expect { thirty_eur / 'jesus' }.to raise_error(TypeError,'The type must be a number or Money')
    end

    it 'compares two moneys and raise a type error' do
      expect { thirty_eur > 'jesus' }.to raise_error(TypeError,'The type must be a number or Money')
      expect { thirty_eur < 'jesus' }.to raise_error(TypeError,'The type must be a number or Money')
      expect { thirty_eur == 'jesus' }.to raise_error(TypeError,'The type must be a number or Money')
    end

    it 'divides by zero' do
      expect { thirty_eur / Money.new(0,'EUR') }.to raise_error( ZeroDivisionError,'The division cannot be by 0')
      expect { thirty_eur / 0 }.to raise_error( ZeroDivisionError,'The division cannot be by 0')
    end

  end


end
