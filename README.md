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

### Get a OHLC (Open, High, Low, Close) price

Fetches a single stock OHLC price. Open and Close prices contain timestamp.
```ruby
ohlc = IEX::Resources::OHLC.get('MSFT')

ohlc.close.price # 90.165
ohlc.close.time #
ohlc.open.price # 0.375
ohlc.open.time
ohlc.high # 0.00418
ohlc.low # '+0.42%'
```

### Get a market OHLC (Open, High, Low, Close) prices

Fetches a hash market OHLC prices.
```ruby
market = IEX::Resources::OHLC.market
market['SPY'].close.price # 278.56
market['SPY'].close.time # 2018-06-11 23:00:00 +0300
market['SPY'].open.price # 279.05
market['SPY'].open.time # 2018-06-12 16:30:00 +0300
market['SPY'].high #
market['SPY'].low #
```

### Get Company Information

Fetches company information for a symbol.

```ruby
company = IEX::Resources::Company.get('MSFT')

company.ceo # 'Satya Nadella'
company.company_name # 'Microsoft Corporation'
```

See [#company](https://iextrading.com/developer/docs/#company) for detailed documentation or [company.rb](lib/iex/resources/company.rb) for returned fields.

### Get Company Logo

Fetches company logo for a symbol.

```ruby
logo = IEX::Resources::Logo.get('MSFT')

logo.url # 'https://storage.googleapis.com/iex/api/logos/MSFT.png'
```

See [#logo](https://iextrading.com/developer/docs/#logo) for detailed documentation or [logo.rb](lib/iex/resources/logo.rb) for returned fields.

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

### Get Chart

Fetches charts for a symbol.

```ruby
chart = IEX::Resources::Chart.get('MSFT')

chart.size # 38510

first = chart.first
first.label # '9:30 AM'
first.high # 94.97
```

You can specify a chart range and additional options.

```ruby
# 1d or 1m data depending on the day or week and time of day
IEX::Resources::Chart.get('MSFT', 'dynamic')

# a specific date
IEX::Resources::Chart.get('MSFT', Date.new(2018, 3, 26))

# every n-th data point
IEX::Resources::Chart.get('MSFT', '1d', chart_interval: 10)
```

See [#chart](https://iextrading.com/developer/docs/#chart) for detailed documentation or [chart/default](lib/iex/resources/chart/default.rb) and [chart/one_day](lib/iex/resources/chart/one_day.rb) for returned fields.

## Errors

### SymbolNotFound

If a symbol cannot be found an [IEX::Errors::SymbolNotFound](lib/iex/errors/symbol_not_found_error.rb) exception is raised.

### ClientError

All errors that return HTTP codes 400-600 result in a [IEX::Errors::ClientError](lib/iex/errors/client_error.rb) exception.

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2018, [Daniel Doubrovkine](https://twitter.com/dblockdotorg) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).

Data provided for free by [IEX](https://iextrading.com/developer), see [terms](https://iextrading.com/api-terms).
