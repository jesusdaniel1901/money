# Money

This gem is to complete operation with money and currency conversion. The main purpose of this gem is to show my skills on ruby, 
either way if you want to use it or if you want to contribute feel free to do it


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'money'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install money

## Usage
```
require 'money'

# Configure the currency rates with respect to a base currency
Money.conversion_rates('EUR', {
  'USD'     => 1.07,
  'GBP' => 0.86
})
# Instantiate money objects
thirty_eur = Money.new(30,'EUR')
thirty_eur.amount #=> 30.00
thirty_eur.currency #=> "EUR"
thirty_eur.inspect #=> "30.0 EUR"
```

```
# Convert to a different currency
twenty_eur.convert_to('USD') # => 21.6 USD
```

```
# Arithmetics
twenty_usd = Money.new(20, 'USD')
thirty_eur = Money.new(30, 'EUR')
thirty_eur + twenty_usd # => 48.41 EUR
thirty_eur - twenty_usd # => 11.59 EUR
thirty_eur / twenty_usd # => 1.63 EUR
thirty_eur * twenty_usd # => 552.3 EUR

thirty_usd * 3 #=> 90.0 USD
thirty_usd / 3 #=> 10.0 USD
```

```
# Comparisons
twenty_usd = Money.new(20, 'USD')
thirty_eur = Money.new(30, 'EUR')

thirty_eur == Money.new(30, 'EUR') # => true
thirty_eur == Money.new(20, 'EUR') # => false 

 
thirty_eur > Money.new(20,'USD')   # => true
twenty_usd < Money.new(20,'GBP')   # => true

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/money. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

