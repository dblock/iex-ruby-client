# IEX Finance API

[![Gem Version](https://badge.fury.io/rb/iex-ruby-client.svg)](https://badge.fury.io/rb/iex-ruby-client)
[![Build Status](https://travis-ci.org/dblock/iex-ruby-client.svg?branch=master)](https://travis-ci.org/dblock/iex-ruby-client)

A Ruby client for the [The IEX Cloud API](https://iexcloud.io/docs/api/).

# Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Get an API Token](#get-an-api-token)
  - [Configure](#configure)
  - [Get a Single Price](#get-a-single-price)
  - [Get a Quote](#get-a-quote)
  - [Get a OHLC (Open, High, Low, Close) price](#get-a-ohlc-open-high-low-close-price)
  - [Get a Market OHLC (Open, High, Low, Close) prices](#get-a-market-ohlc-open-high-low-close-prices)
  - [Get Company Information](#get-company-information)
  - [Get a Company Logo](#get-a-company-logo)
  - [Get Recent News](#get-recent-news)
  - [Get Chart](#get-chart)
  - [Get Key Stats](#get-key-stats)
  - [Get Dividends](#get-dividends)
  - [Get Earnings](#get-earnings)
  - [Get Income Statement](#get-income-statement)
  - [Get Sector Performance](#get-sector-performance)
  - [Get Largest Trades](#get-largest-trades)
  - [Get a Quote for Crypto Currencies](#get-a-quote-for-crypto-currencies)
- [Configuration](#configuration)
- [Errors](#errors)
  - [SymbolNotFound](#symbolnotfound)
  - [PermissionDeniedError](#permissiondeniederror)
  - [ClientError](#clienterror)
- [Contributing](#contributing)
- [Copyright and License](#copyright-and-license)

## Installation

Add to Gemfile.

```
gem 'iex-ruby-client'
```

Run `bundle install`.

## Usage

### Get an API Token

Create an account on [IEX Cloud](https://iexcloud.io) and get a publishable token from the IEX cloud console. You should use a sandbox token and endpoint for testing.

### Configure

```ruby
IEX::Api.configure do |config|
  config.publishable_token = 'token' # defaults to ENV['IEX_API_PUBLISHABLE_TOKEN']
  config.endpoint = 'https://sandbox.iexapis.com/v1' # defaults to 'https://cloud.iexapis.com/v1'
end
```

You can also configure an instance of a client directly.

```ruby
client = IEX::Api::Client.new(
  publishable_token: 'token',
  endpoint: 'https://sandbox.iexapis.com/v1'
)
```

### Get a Single Price

Fetches a single number, being the IEX real time price, the 15 minute delayed market price, or the previous close price.

```ruby
client.price('MSFT') # 93.78
```

See [#price](https://iexcloud.io/docs/api/#price) for detailed documentation.

### Get a Quote

Fetches a single stock quote.

```ruby
quote = client.quote('MSFT')

quote.latest_price # 90.165
quote.change # 0.375
quote.change_percent # 0.00418
quote.change_percent_s # '+0.42%'
```

See [#quote](https://iexcloud.io/docs/api/#quote) for detailed documentation or [quote.rb](lib/iex/resources/quote.rb) for returned fields.

### Get a OHLC (Open, High, Low, Close) price

Fetches a single stock OHLC price. Open and Close prices contain timestamp.

```ruby
ohlc = client.ohlc.get('MSFT')

ohlc.close.price # 90.165
ohlc.close.time #
ohlc.open.price # 0.375
ohlc.open.time
ohlc.high # 0.00418
ohlc.low # '+0.42%'
```

### Get a Market OHLC (Open, High, Low, Close) prices

Fetches a hash market OHLC prices.

```ruby
market = client.market
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
company = client.company('MSFT')

company.ceo # 'Satya Nadella'
company.company_name # 'Microsoft Corporation'
```

See [#company](https://iexcloud.io/docs/api/#company) for detailed documentation or [company.rb](lib/iex/resources/company.rb) for returned fields.

### Get a Company Logo

Fetches company logo for a symbol.

```ruby
logo = client.logo('MSFT')

logo.url # 'https://storage.googleapis.com/iex/api/logos/MSFT.png'
```

See [#logo](https://iexcloud.io/docs/api/#logo) for detailed documentation or [logo.rb](lib/iex/resources/logo.rb) for returned fields.

### Get Recent News

Fetches news for a symbol.

```ruby
news = client.news('MSFT')

news.size # 10

latest = news.first
latest.headline # 'Smartsheet files for $100M IPO with growing losses'
latest.url # 'https://...'
```

Retrieve a range between 1 and 50.

```ruby
news = client.news('MSFT', 5)
```

See [#news](https://iexcloud.io/docs/api/#news) for detailed documentation or [news.rb](lib/iex/resources/news.rb) for returned fields.

### Get Chart

Fetches charts for a symbol.

```ruby
chart = client.chart('MSFT')

chart.size # 38510

first = chart.first
first.label # '9:30 AM'
first.high # 94.97
```

You can specify a chart range and additional options.

```ruby
client.chart('MSFT', 'dynamic') # 1d or 1m data depending on the day or week and time of day
client.chart('MSFT', Date.new(2018, 3, 26)) # a specific date
client.chart('MSFT', '1d', chart_interval: 10) # every n-th data point
```

Note that calling the chart API weighs more than 1 IEX message (you pay more than 1 call).

```
# 1 message per minute capped at 50 messages to intraday_prices
client.chart('MSFT', '1d')

# 2x22 trading days = 44 messages to historical_close_prices
client.chart('MSFT', '1m', chart_close_only: true)

# 2x251 trading days = 502 messages to historical_close_prices
client.chart('MSFT', '1y', chart_close_only: true)
```

### Get Key Stats

Fetches company's key stats for a symbol.

```ruby
key_stats = client.key_stats('MSFT')

key_stats.week_52_change_dollar # "$0.37"
key_stats.week_52_high # 136.04
key_stats.week_52_high_dollar # "$136.04"
key_stats.week_52_low # 95.92,
key_stats.week_52_low_dollar # "$95.92"
key_stats.market_cap # 990869169557
key_stats.market_cap_dollar # "$990,869,169,557"
key_stats.employees # 133074
key_stats.day_200_moving_avg # 112.43
key_stats.day_50_moving_avg # 121
key_stats.float # 7694414092
key_stats.avg_10_volume # 25160156.2
key_stats.avg_30_volume # 23123700.13
key_stats.ttm_eps # 4.66
key_stats.ttm_dividend_rate # 1.8
key_stats.company_name # "Microsoft Corp."
key_stats.shares_outstanding # 7849945172
key_stats.max_change_percent # 4.355607
key_stats.year_5_change_percent # 2.32987
key_stats.year_5_change_percent_s # "+232.99%"
key_stats.year_2_change_percent # 0.84983
key_stats.year_2_change_percent_s # "+84.98%"
key_stats.year_1_change_percent # 0.383503
key_stats.year_1_change_percent_s # "+38.35%"
key_stats.ytd_change_percent # 0.270151
key_stats.ytd_change_percent_s # "+27.02%"
key_stats.month_6_change_percent # 0.208977
key_stats.month_6_change_percent_s # "+20.90%"
key_stats.month_3_change_percent # 0.212188
key_stats.month_3_change_percent_s # "+21.22%"
key_stats.month_1_change_percent # 0.076335
key_stats.month_1_change_percent_s # "+7.63%"
key_stats.day_30_change_percent # 0.089589
key_stats.day_30_change_percent_s # "+8.96%"
key_stats.day_5_change_percent # -0.010013
key_stats.day_5_change_percent_s # "-1.00%"
key_stats.next_dividend_date # "2019-05-21"
key_stats.dividend_yield # 0.014087248841960684
key_stats.next_earnings_date # "2019-07-29"
key_stats.ex_dividend_date # "2019-05-24"
key_stats.pe_ratio # 29.47
key_stats.beta # 1.4135449089973444
```

See [#key-stats](https://iexcloud.io/docs/api/#key-stats) for detailed documentation or [key_stats.rb](lib/iex/resources/key_stats.rb) for returned fields.

### Get Dividends

Fetches dividends for a symbol.

```ruby
dividends = client.dividends('MSFT', '6m') # Options are: 5y, 2y, 1y, ytd, 6m, 3m, 1m

dividends.payment_date # '2018-03-08'
dividends.record_date # '2018-02-15'
dividends.declared_date # '2017-11-29'
dividends.amount # 0.42
```

See [#dividends](https://iexcloud.io/docs/api/#dividends) for detailed documentation or [dividends.rb](lib/iex/resources/dividends.rb) for returned fields.

### Get Earnings

Fetches earnings for a symbol.

```ruby
earnings = client.earnings('MSFT')

earnings.actual_eps # 1.13
earnings.consensus_eps # 1.07
earnings.announce_time # 'AMC'
earnings.number_of_estimates # 14
earnings.eps_surprise_dollar # 0.06
earnings.eps_report_date # '2018-07-19'
earnings.fiscal_period # 'Q4 2018'
earnings.fiscal_end_date # '2018-06-30'
earnings.year_ago # 0.98
earnings.year_ago_change_percent # 0.15306122448979584
earnings.year_ago_change_percent_s # '+15.31%'
```

See [#earnings](https://iexcloud.io/docs/api/#earnings) for detailed documentation or [earnings.rb](lib/iex/resources/earnings.rb) for returned fields.

### Get Income Statement

Fetches income statement for a symbol.

```ruby
income = client.income('MSFT')

income.report_date # '2019-03-31'
income.total_revenue # 30_505_000_000
income.total_revenue_dollar # '$30,505,000,000'
income.cost_of_revenue # 10_170_000_000
income.cost_of_revenue_dollar # '$10,170,000,000'
income.gross_profit # 20_335_000_000
income.gross_profit_dollar # '$20,335,000,000'
...
```

See [#income-statement](https://iexcloud.io/docs/api/#income-statement) for detailed documentation or [income.rb](lib/iex/resources/income.rb) for returned fields.

### Get Sector Performance

Fetches latest sector's performance.

```ruby
sectors = client.sectors('MARKET')

sectors.type # sectors
sectors.name # Industrials
sectors.performance # 0.00711
sectors.last_updated # 1533672000437
```

See [#sector-performance](https://iexcloud.io/docs/api/#sector-performance) for detailed documentation or [sectors.rb](lib/iex/resources/sectors.rb) for returned fields.

### Get Largest Trades

Fetches largest trades in the day for a specific stock. Ordered by largest trade on the top.

```ruby
trades = client.largest_trades('aapl')

trades.first.price # 186.39
trades.first.size # 10000 - refers to the number of shares negotiated in the day.
trades.first.time # 1527090690175
trades.first.time_label # 11:51:30
trades.first.venue # EDGX
trades.first.venue_name # Cboe EDGX
```

See [#largest-trades](https://iexcloud.io/docs/api/#largest-trades) for detailed documentation or [largest_trades.rb](lib/iex/resources/largest_trades.rb) for returned fields.

### Get a Quote for Crypto Currencies

Fetches a crypto currency quote.

```ruby
crypto = client.crypto('BTCUSDT')

crypto.symbol #'BTCUSDT'
crypto.company_name #'Bitcoin USD'
crypto.primary_exchange #'crypto'
crypto.sector #'cryptocurrency'
crypto.calculation_price #'realtime'
crypto.open #3527.79
crypto.open_dollar #'$3,527'
crypto.open_time #1_548_082_840_296
crypto.close #3522.05522498
crypto.close_dollar #'$3,522'
crypto.close_time #1_548_169_240_296
crypto.high #3590.51
crypto.high_dollar #'$3,590'
```

See [#crypto](https://iexcloud.io/docs/api/#crypto) for detailed documentation or [crypto.rb](lib/iex/resources/crypto.rb) for returned fields.

## Configuration

You can configure client options globally or directly with a `IEX::Api::Client` instance.

```ruby
IEX::Api::Client.configure do |config|
  config.publishable_token = ENV['IEX_API_PUBLISHABLE_TOKEN']
  config.endpoint = 'https://sandbox.iexapis.com/v1' # use sandbox environment
end
```

```ruby
client = IEX::Api::Client.new(
  publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
  endpoint: 'https://sandbox.iexapis.com/v1'
)
```

The following settings are supported.

setting             | description
--------------------|------------
user_agent          | User-agent, defaults to _IEX Ruby Client/version_.
proxy               | Optional HTTP proxy.
ca_path             | Optional SSL certificates path.
ca_file             | Optional SSL certificates file.
logger              | Optional `Logger` instance that logs HTTP requests.
timeout             | Optional open/read timeout in seconds.
open_timeout        | Optional connection open timeout in seconds.
publishable_token   | IEX Cloud API publishable token.
endpoint            | Defaults to `https://cloud.iexapis.com/v1`.

## Errors

### SymbolNotFound

If a symbol cannot be found an [IEX::Errors::SymbolNotFound](lib/iex/errors/symbol_not_found_error.rb) exception is raised.

### PermissionDeniedError

All errors that return HTTP code 403 result in a [IEX::Errors::PermissionDeniedError](lib/iex/errors/permission_denied_error.rb) exception.

### ClientError

All errors that return HTTP codes 400-600 result in a [IEX::Errors::ClientError](lib/iex/errors/client_error.rb) exception.

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2018-2019, [Daniel Doubrovkine](https://twitter.com/dblockdotorg) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).

Data provided for free by [IEX](https://iexcloud.io), see [terms](https://iexcloud.io/terms/).
