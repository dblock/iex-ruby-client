IEX Finance API
===============

[![Gem Version](https://badge.fury.io/rb/iex-ruby-client.svg)](https://badge.fury.io/rb/iex-ruby-client)
[![Build Status](https://travis-ci.org/dblock/iex-ruby-client.svg?branch=master)](https://travis-ci.org/dblock/iex-ruby-client)

A Ruby client for the [IEX Finance API](https://iextrading.com/developer).


# Table of Contents

- [Installation](#installation)
- [Methods Available](#methods-available)
- [Usage](#usage)
  - [Get a Single Price](#get-a-single-price)
  - [Get a Quote](#get-a-quote)
  - [Get a OHLC (Open, High, Low, Close) price](#get-a-ohlc-open-high-low-close-price)
  - [Get a market OHLC (Open, High, Low, Close) prices](#get-a-market-ohlc-open-high-low-close-prices)
  - [Get Company Information](#get-company-information)
  - [Get a Company Logo](#get-a-company-logo)
  - [Get Recent News](#get-recent-news)
  - [Get Chart](#get-chart)
  - [Get Key Stats](#get-key-stats)
  - [Get Dividends](#get-dividends)
  - [Get Earnings](#get-earnings)
- [Errors](#errors)
  - [SymbolNotFound](#symbolnotfound)
  - [ClientError](#clienterror)
- [Contributing](#contributing)
- [Copyright and License](#copyright-and-license)


## Installation

Add to Gemfile.

```
gem 'iex-ruby-client'
```

Run `bundle install`.


## Methods Available

- [Get a Single Price](#get-a-single-price)
- [Get a Quote](#get-a-quote)
- [Get a OHLC (Open, High, Low, Close) price](#get-a-ohlc-open-high-low-close-price)
- [Get a Market OHLC (Open, High, Low, Close) prices](#get-a-market-ohlc-open-high-low-close-prices)
- [Get Company Information](#get-company-information)
- [Get Company Logo](#get-company-logo)
- [Get Recent News](#get-recent-news)
- [Get Chart](#get-chat)
- [Get Key Stats](#get-key-stats)
- [Get Dividends](#get-dividends)
- [Get Earnings](#get-earnings)


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

### Get a Company Logo

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
IEX::Resources::Chart.get('MSFT', 'dynamic') # 1d or 1m data depending on the day or week and time of day
IEX::Resources::Chart.get('MSFT', Date.new(2018, 3, 26)) # a specific date
IEX::Resources::Chart.get('MSFT', '1d', chart_interval: 10) # every n-th data point
```

### Get Key Stats

Fetches company's key stats for a symbol.

```ruby
key_stats = IEX::Resources::KeyStats.get('MSFT')

key_stats.symbol # MSFT
key_stats.market_cap # 825814890000
key_stats.market_cap_dollars # '$825,814,890,000'
key_stats.beta # 1.261768
key_stats.week_52_high # 111.15
key_stats.week_52_high_dollar # '$111.15'
key_stats.week_52_low # 71.28
key_stats.week_52_low_dollar # '$71.28'
key_stats.week_52_change_dollar # '$51.77'
key_stats.short_interest # 47158592
key_stats.short_date # '2018-07-13'
key_stats.dividend_rate # 1.68
key_stats.dividend_yield # 1.5617738
key_stats.ex_dividend_date # '2018-08-15 00:00:00.0'
key_stats.latest_eps # 2.11
key_stats.latest_eps_date # '2018-06-30'
key_stats.shares_outstanding # 7677000000
key_stats.float # 7217387757
key_stats.return_on_equity # 20.82
key_stats.consensus_eps # 0.86
key_stats.number_of_estimates # 14
key_stats.eps_surprise_dollar # nil
key_stats.eps_surprise_percent # 11.6279
key_stats.eps_surprise_percent_s # '+1162.79%'
key_stats.ebitda # 23558000000
key_stats.revenue_dollar # '$53,456,000,000'
key_stats.gross_profit # 34114000000
key_stats.gross_profit_dollar # '$34,114,000,000'
key_stats.cash_dollar # '$281,251,000,000'
key_stats.ttm_eps # 3.51
key_stats.revenue_per_share # 7
key_stats.revenue_per_employee # 431097
key_stats.pe_ratio_high # 0
key_stats.pe_ratio_low # 0
key_stats.return_on_assets # 6.46
key_stats.return_on_capital # nil
key_stats.profit_margin # 15.1
key_stats.price_to_sales # 7.393182
key_stats.price_to_sales_dollar # '$7.39'
key_stats.price_to_book # 10.73
key_stats.price_to_book_dollar # '$10.73'
key_stats.day_200_moving_avg # 91.99065
key_stats.day_50_moving_avg # 102.2528
key_stats.institution_percent # 75.1
key_stats.institution_percent_s # '+7510.00%'
key_stats.insider_percent # nil
key_stats.insider_percent_s # nil
key_stats.short_ratio # 1.7330703
key_stats.year_5_change_percent # 2.85141424991049
key_stats.year_5_change_percent_s # '+285.14%'
key_stats.year_2_change_percent # 0.9732002824884664
key_stats.year_2_change_percent_s # '+97.32%'
key_stats.year_1_change_percent # 0.5200287133805482
key_stats.year_1_change_percent_s # '+52.00%'
key_stats.ytd_change_percent # 0.2628699562098638
key_stats.month_6_change_percent # 0.23345097958275707
key_stats.month_6_change_percent_s # '+23.35%'
key_stats.month_3_change_percent # 0.14846686026648437
key_stats.month_3_change_percent_s # '+14.85%'
key_stats.month_1_change_percent # 0.08601716304896513
key_stats.month_1_change_percent_s # '+8.60%'
key_stats.day_5_change_percent # -0.0010215453194652084
key_stats.day_5_change_percent_s # '-0.10%'
```
See [#key-stats](https://iextrading.com/developer/docs/#key-stats) for detailed documentation or [key_stats.rb](lib/iex/resources/key_stats.rb) for returned fields.

### Get Dividends

Fetches dividends for a symbol.

```ruby
dividends = IEX::Resources::Dividends.get('MSFT', '6m') # Options are: 5y, 2y, 1y, ytd, 6m, 3m, 1m

dividends.payment_date # '2018-03-08'
dividends.record_date # '2018-02-15'
dividends.declared_date # '2017-11-29'
dividends.amount # 0.42
dividends.amount_dollar # '$0.42'
dividends.flag # ''
dividends.type # 'Dividend income'
dividends.qualified # 'Q'
dividends.indicated # ''
```
See [#dividends](https://iextrading.com/developer/docs/#dividends) for detailed documentation or [dividends.rb](lib/iex/resources/dividends.rb) for returned fields.


### Get Earnings

Fetches earnings for a symbol.

```ruby
earnings = IEX::Resources::Earnings.get('MSFT')

earnings.actual_eps # 1.13
earnings.consensus_eps # 1.07
earnings.estimated_eps # 1.07
earnings.announce_time # 'AMC'
earnings.number_of_estimates # 14
earnings.eps_surprise_dollar # 0.06
earnings.eps_report_date # '2018-07-19'
earnings.fiscal_period # 'Q4 2018'
earnings.fiscal_end_date # '2018-06-30'
earnings.year_ago # 0.98
earnings.year_ago_change_percent # 0.15306122448979584
earnings.year_ago_change_percent_s # '+15.31%'
earnings.estimated_change_percent # 0.09183673469387764
earnings.estimated_change_percent_s # '+9.18%'
earnings.symbol_id # 4563
```
See [#earnings](https://iextrading.com/developer/docs/#earnings) for detailed documentation or [earnings.rb](lib/iex/resources/earnings.rb) for returned fields.


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
