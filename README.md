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
  - [Get Historical Prices](#get-historical-prices)
  - [Get Company Information](#get-company-information)
  - [Get a Company Logo](#get-a-company-logo)
  - [Get Recent News](#get-recent-news)
  - [Get Chart](#get-chart)
  - [Get Key Stats](#get-key-stats)
  - [Get Advanced Stats](#get-advanced-stats)
  - [Get Dividends](#get-dividends)
  - [Get Earnings](#get-earnings)
  - [Get Income Statement](#get-income-statement)
  - [Get Balance Sheet](#get-balance-sheet)
  - [Get Cash Flow Statement](#get-cash-flow-statement)
  - [Get Sector Performance](#get-sector-performance)
  - [Get Largest Trades](#get-largest-trades)
  - [Get a Quote for Crypto Currencies](#get-a-quote-for-crypto-currencies)
  - [ISIN Mapping](#isin-mapping)
  - [Get Symbols](#get-symbols)
  - [Get List](#get-list)
  - [Other Requests](#other-requests)
- [Configuration](#configuration)
  - [Logging](#logging)
- [Sandbox Environment](#sandbox-environment)
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

Create an account on [IEX Cloud](https://iexcloud.io) and get a publishable token from the IEX cloud console.

### Configure

```ruby
IEX::Api.configure do |config|
  config.publishable_token = 'publishable_token' # defaults to ENV['IEX_API_PUBLISHABLE_TOKEN']
  config.secret_token = 'secret_token' # defaults to ENV['IEX_API_SECRET_TOKEN']
  config.endpoint = 'https://cloud.iexapis.com/v1' # use 'https://sandbox.iexapis.com/v1' for Sandbox
end
```

You can also configure an instance of a client directly.

```ruby
client = IEX::Api::Client.new(
  publishable_token: 'publishable_token',
  secret_token: 'secret_token',
  endpoint: 'https://cloud.iexapis.com/v1'
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
ohlc = client.ohlc('MSFT')

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

### Get Historical Prices

Fetches a list of historical prices.

There are currently a few limitations of this endpoint compared to the official IEX one.

Options for `range` include:
`max, ytd, 5y, 2y, 1y, 6m, 3m, 1m, 5d, date`

NOTE: If you use the `date` value for the `range` parameter:
 * The options _must_ include a date entry, `{date: ...}`
 * The date value _must_ be either a Date object, or a string formatted as `YYYYMMDD`. Anything else will result in an `IEX::Errors::ClientError`.
 * The options _must_ include `chartByDay: 'true'` or an `ArgumentError` will be raised.
 * See below for examples.

`Query params` supported include:
`chartByDay`

This is a complicated endpoint as there is a lot of granularity over the time period of data returned. See below for a variety of ways to request data, NOTE: this is _NOT_ as exhaustive list. 
```ruby
historial_prices = client.historical_prices('MSFT') # One month of data
historial_prices = client.historical_prices('MSFT', {range: 'max'}) # All data up to 15 years
historial_prices = client.historical_prices('MSFT', {range: 'ytd'}) # Year to date data
historial_prices = client.historical_prices('MSFT', {range: '5y'}) # 5 years of data
historial_prices = client.historical_prices('MSFT', {range: '6m'}) # 6 months of data
historial_prices = client.historical_prices('MSFT', {range: '5d'}) # 5 days of data
historial_prices = client.historical_prices('MSFT', {range: 'date', date: '20200930', chartByDay: 'true'}) # One day of data
historial_prices = client.historical_prices('MSFT', {range: 'date', date: Date.parse('2020-09-30)', chartByDay: 'true'}) # One day of data
...
```

Once you have the data over the preferred time period, you can access the following fields
```ruby
historial_prices = client.historical_prices('MSFT') # One month of data

historial_price = historial_prices.first
historical_price.date # 2020-10-07
historical_price.open #207.06
historical_price.open_dollar # '$207.06'
historical_price.close # 209.83
historical_price.close_dollar # '$209.83'
historical_price.high # 210.11
historical_price.high_dollar # '$210.11'
historical_price.low # 206.72
historical_price.low_dollar # '$206.72'
historical_price.volume # 25681054
...
```

There are a lot of options here so I would recommend viewing the official IEX documentation [#historical-prices](https://iexcloud.io/docs/api/#historical-prices) or [historical_prices.rb](lib/iex/resources/historical_prices.rb) for returned fields.

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

### Get Advanced Stats

Fetches company's advanced stats for a symbol, this will include all key stats as well.

```ruby
advanced_stats = client.advanced_stats('MSFT')

advanced_stats.total_cash # 66301000000
advanced_stats.total_cash_dollars # "$66,301,000,000"
advanced_stats.current_debt # 20748000000
advanced_stats.current_debt_dollars # "$2,074,8000,000"
advanced_stats.revenue # 265809000000
advanced_stats.revenue_dollars # "$265,809,000,000"
advanced_stats.gross_profit # 101983000000 
advanced_stats.gross_profit_dollar # "$101,983,000,000"
advanced_stats.total_revenue # 265809000000
advanced_stats.total_revenue_dollar # "$265,809,000,000"
advanced_stats.ebitda # 80342000000
advanced_stats.ebitda_dollar # "$80,342,000,000"
advanced_stats.revenue_per_share # 0.02
advanced_stats.revenue_per_share_dollar # "$0.02"
advanced_stats.revenue_per_employee # 2013704.55
advanced_stats.revenue_per_employee_dollar # "$2,013,704.55"
advanced_stats.debt_to_equity # 1.07
advanced_stats.profit_margin # 22.396157
advanced_stats.enterprise_value # 1022460690000
advanced_stats.enterprise_value_dollar # "$1,022,460,690,000"
advanced_stats.enterprise_value_to_revenue # 3.85
advanced_stats.price_to_sales # 3.49
advanced_stats.price_to_sales_dollar # "$3.49"
advanced_stats.price_to_book # 8.805916432564608
advanced_stats.forward_pe_ratio # 18.14
advanced_stats.pe_high # 22.61
advanced_stats.pe_low # 11.98
advanced_stats.peg_ratio # 2.19
advanced_stats.week_52_high_date # "2019-11-19"
advanced_stats.week_52_low_date # "2019-01-03
advanced_stats.beta # 1.4661365583766115
advanced_stats.put_call_ratio # 0.6780362005229779
...
```

See [#advanced-stats](https://iexcloud.io/docs/api/#advanced-stats) for detailed documentation or [advanced_stats.rb](lib/iex/resources/advanced_stats.rb) for returned fields.

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

Fetches income statements for a symbol.

```ruby
income_statements = client.income('MSFT')

# Multiple income statements are returned with 1 API call.
income = income_statements.first
income.report_date # '2019-03-31'
income.fiscal_date # '2019-03-31'
income.currency # 'USD'
income.total_revenue # 30_505_000_000
income.total_revenue_dollar # '$30,505,000,000'
income.cost_of_revenue # 10_170_000_000
income.cost_of_revenue_dollar # '$10,170,000,000'
income.gross_profit # 20_335_000_000
income.gross_profit_dollar # '$20,335,000,000'
...
```

See [#income-statement](https://iexcloud.io/docs/api/#income-statement) for detailed documentation or [income.rb](lib/iex/resources/income.rb) for returned fields.

### Get Balance Sheet

Fetches balance sheets for a symbol.

```ruby
balance_sheets = client.balance_sheet('MSFT')

# Multiple balance sheets are returned with 1 API call.
balance_sheet = balance_sheets.first
balance_sheet.report_date # '2017-03-31'
balance_sheet.fiscal_date # '2017-03-31'
balance_sheet.currency # 'USD'
balance_sheet.current_cash # 25_913_000_000
balance_sheet.current_cash_dollar # '$25,913,000,000'
balance_sheet.short_term_investments # 40_388_000_000
balance_sheet.short_term_investments_dollar # '$40,388,000,000'
...
```

See [#balance-sheet](https://iexcloud.io/docs/api/#balance-sheet) for detailed documentation or [balance_sheet.rb](lib/iex/resources/balance_sheet.rb) for returned fields.

### Get Cash Flow Statement

Fetches cash flow statements for a symbol.

```ruby
cash_flow_statements = client.cash_flow('MSFT')

# Multiple cash flow statements are returned with 1 API call.
cash_flow = cash_flow_statements.first
cash_flow.report_date # '2018-09-30'
cash_flow.fiscal_date # '2018-09-30'
cash_flow.currency # 'USD'
cash_flow.net_income # 14_125_000_000
cash_flow.net_income_dollar # '$14,125,000,000'
cash_flow.depreciation # 2_754_000_000
cash_flow.depreciation_dollar # '$2,754,000,000'
...
```

See [#cash-flow](https://iexcloud.io/docs/api/#cash-flow) for detailed documentation or [cash_flow.rb](lib/iex/resources/cash_flow.rb) for returned fields.

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

### ISIN Mapping

Convert ISIN to IEX Cloud symbols.

```ruby
symbols = client.ref_data_isin('US0378331005')

symbols.first.exchange # NAS
symbols.first.iex_id # IEX_4D48333344362D52
symbols.first.region # US
symbols.first.symbol # AAPL
```

The API also lets you convert multiple ISINs to IEX Cloud symbols.

```ruby
symbols = client.ref_data_isin(['US0378331005', 'US0378331006'])
```


You can use `mapped: true` option to receive symbols grouped by their ISINs.

```ruby
client.ref_data_isin(['US0378331005', 'US5949181045'], mapped: true) # {'US0378331005' => [...], 'US5949181045' => [...]}
```

See [#ISIN Mapping](https://iexcloud.io/docs/api/#isin-mapping) for detailed documentation or [isin_mapping.rb](lib/iex/resources/isin_mapping.rb) for returned fields.

### Get Symbols

Returns an array of symbols

```ruby
symbols = client.ref_data_symbols()

symbol = symbols.first
symbol.exchange # NAS
symbol.iex_id # IEX_46574843354B2D52
symbol.region # US
symbol.symbol # A
```

See [#symbols](https://iexcloud.io/docs/api/#symbols) for detailed documentation or [symbols.rb](lib/iex/resources/symbols.rb) for returned fields.

### Get List

Returns an array of quotes for the top 10 symbols in a specified list.

```ruby
client.stock_market_list(:mostactive) # [{symbol: 'AAPL', ...}, {...}]
```

See [#list](https://iexcloud.io/docs/api/#list) for detailed documentation or [quote.rb](lib/iex/resources/quote.rb) for returned fields.

### Other Requests

Public endpoints that aren't yet supported by the client can be called using `client.get`, `client.post`, `client.put`
and `client.delete` methods. Pass the required token explicitly:

```ruby
client.post('ref-data/isin', isin: ['US0378331005'], token: 'secret_token') # [{'exchange' => 'NAS', ..., 'symbol' => 'AAPL'}, {'exchange' => 'ETR', ..., 'symbol' => 'APC-GY']
```

## Configuration

You can configure client options globally or directly with a `IEX::Api::Client` instance.

```ruby
IEX::Api.configure do |config|
  config.publishable_token = ENV['IEX_API_PUBLISHABLE_TOKEN']
  config.endpoint = 'https://sandbox.iexapis.com/v1' # use sandbox environment
end
```

```ruby
client = IEX::Api::Client.new(
  publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
  endpoint: 'https://cloud.iexapis.com/v1'
)
```

The following settings are supported.

setting             | description
--------------------|------------
user_agent          | User-agent, defaults to _IEX Ruby Client/version_.
proxy               | Optional HTTP proxy.
ca_path             | Optional SSL certificates path.
ca_file             | Optional SSL certificates file.
logger              | Optional `Logger` instance or logger configuration to log HTTP requests.
timeout             | Optional open/read timeout in seconds.
open_timeout        | Optional connection open timeout in seconds.
publishable_token   | IEX Cloud API publishable token.
endpoint            | Defaults to `https://cloud.iexapis.com/v1`.
referer             | Optional string for HTTP `Referer` header, enables token domain management.

### Logging

Faraday will not log HTTP requests by default. In order to do this you can either provide a `logger` instance or configuration attributes to `IEX::Api::Client`. Configuration allows you to supply the `instance`, `options`, and `proc` to [Faraday](https://lostisland.github.io/faraday/middleware/logger#include-and-exclude-headersbodies).

```ruby
logger_instance = Logger.new(STDOUT)

IEX::Api.configure do |config|
  config.logger.instance = logger_instance
  config.logger.options = { bodies: true }
  config.logger.proc = proc { |logger| logger.filter(/T?[sp]k_\w+/i, '[REMOVED]') }
end
# or
IEX::Api.logger do |logger|
  logger.instance = logger_instance
  logger.options = …
  logger.proc = …
end
# or
IEX::Api.logger = logger_instance
# or
IEX::Api::Client.new(logger: logger_instance)
```

## Sandbox Environment

IEX recommends you use a sandbox token and endpoint for testing.

However, please note that data in the IEX sandbox environment is scrambled. Therefore elements such as company and people names, descriptions, tags, and website URLs don't render any coherent data. In addition, results, such as closing market prices and dividend yield, are not accurate and vary on every call.

See [IEX sandbox environment](https://intercom.help/iexcloud/en/articles/2915433-testing-with-the-iex-cloud-sandbox) for more information.

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
