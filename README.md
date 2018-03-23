IEX Finance API
===============

[![Gem Version](https://badge.fury.io/rb/iex-ruby-client.svg)](https://badge.fury.io/rb/iex-ruby-client)
[![Build Status](https://travis-ci.org/dblock/iex-ruby-client.svg?branch=master)](https://travis-ci.org/dblock/iex-ruby-client)

A Ruby client for the [IEX Finance API](https://iextrading.com/developer).

## Installation

Add to Gemfile.

```
gem 'iex-ruby-client'
```

Run `bundle install`.

## Usage

### Get a Quote

Fetches a single stock quote.

```ruby
quote = IEX::Quote.get('MSFT')

quote.last_trade_price # 84.26
quote.change # 0.09
quote.change_percent # 0.11
```

See [#quote](https://iextrading.com/developer/docs/#quote) for detailed documentation or [quote.rb](lib/iex/quote.rb) for returned fields.

If a symbol cannot be found an [IEX::Errors::SymbolNotFound](lib/iex/errors/symbol_not_found_error.rb) exception is raised.

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2018, [Daniel Doubrovkine](https://twitter.com/dblockdotorg) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).

Data provided for free by [IEX](https://iextrading.com/developer), see [terms](https://iextrading.com/api-exhibit-a).
