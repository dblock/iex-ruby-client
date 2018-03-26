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

### Get a Single Price

Fetches a single number, being the IEX real time price, the 15 minute delayed market price, or the previous close price.

```ruby
IEX::Resources::Price.get('MSFT') # 93.78
```

See [#price](https://iextrading.com/developer/docs/#price) for detailed documentation.

### Get a Quote

Fetches a single stock quote.

```ruby
quote = IEX::Resources::Quote.get('MSFT')

quote.latest_price # 90.165
quote.change # 0.375
quote.change_percent # 0.00418
quote.change_percent_s # '+0.42%'
```

See [#quote](https://iextrading.com/developer/docs/#quote) for detailed documentation or [quote.rb](lib/iex/resources/quote.rb) for returned fields.

### Get Company Information

Fetches company information for a symbol.

```ruby
company = IEX::Resources::Company.get('MSFT')

company.ceo # 'Satya Nadella'
company.company_name # 'Microsoft Corporation'
```

See [#company](https://iextrading.com/developer/docs/#company) for detailed documentation or [company.rb](lib/iex/resources/company.rb) for returned fields.

### Get Recent News

Fetches news for a symbol.

```ruby
news = IEX::Resources::News.get('MSFT')

news.size # 10

latest = news.first
latest.headline # 'Smartsheet files for $100M IPO with growing losses'
latest.url # 'https://...'
```

Use `market` to get market-wide news.

```ruby
news = IEX::Resources::News.get(:market)
```

Retrieve a range between 1 and 50.

```ruby
news = IEX::Resources::News.get('MSFT', 5)
```

See [#news](https://iextrading.com/developer/docs/#news) for detailed documentation or [news.rb](lib/iex/resources/news.rb) for returned fields.

## Errors

### SymbolNotFound

If a symbol cannot be found an [IEX::Errors::SymbolNotFound](lib/iex/errors/symbol_not_found_error.rb) exception is raised.

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2018, [Daniel Doubrovkine](https://twitter.com/dblockdotorg) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).

Data provided for free by [IEX](https://iextrading.com/developer), see [terms](https://iextrading.com/api-terms).
