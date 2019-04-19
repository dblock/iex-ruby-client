Upgrading iex-ruby-client
=========================

### Upgrading to >= 1.0.0

On June 1, 2019, IEX API has been sunset for all non-IEX data. IEX Cloud, a non-Exchange platform, continues to provide access to third-party data sources.

Create an account and get a `publishable token` from [IEX Cloud Console](https://iexcloud.io). Set to environment variable `IEX_API_PUBLISHABLE_TOKEN` or configure the client as follows.

```ruby
client = IEX::Api::Client.new(publishable_token: 'token')

# before
# IEX::Resources::Price.get('MSFT')

client.price('MSFT')
```

#### API Changes

##### Company

* Added `security_name` `employees` properties.

##### Dividends

* Added `ex_date` `currency` `description` `frequency` properties.
* Removed `flag` `type` `qualified` `indicated` properties.

##### Earnings

* Removed `estimated_eps` `estimated_change_percent` `estimated_change_percent_s` `symbol_id` properties.

##### KeyStats

* Removed `beta` `short_interest` `short_date` `dividend_rate` `latest_eps` `latest_eps_date` `return_on_equity` `consensus_eps` `number_of_estimates` `symbol` `ebitda` `revenue` `revenue_dollar` `gross_profit` `gross_profit_dollar` `cash` `cash_dollar` `dept` `dept_dollar` `revenue_per_share` `revenue_per_employee` `pe_ratio_high` `pe_ratio_low` `eps_surprise_dollar` `eps_surprise_percent` `eps_surprise_percent_s` `return_on_assets` `return_on_capital` `profit_margin` `price_to_sales` `price_to_book` `price_to_sales_dollar` `price_to_book_dollar` `institution_percent` `institution_percent_s` `insider_percent` `insider_percent_s` `short_ratio` properties.

##### News

* Removed market news.

##### Crypto

* Added a new api to get a quote for Cryptocurrency.

```ruby
crypto = client.crypto('BTCUSDT')
```

### Upgrading to >= 0.4.0

#### All errors that return HTTP codes 400-600 result in a IEX::Errors::ClientError exception

On previous versions, calling `IEX::Resources::Chart.get` with an invalid option results on a
`Faraday::ClientError`. On versions >= 0.4.0, it will return an `IEX::Errors::ClientError`.

Before:

```ruby
IEX::Resources::Chart.get('MSFT', '1d', chart_interval: 10, invalid_option: 'foo')
> Faraday::ClientError: the server responded with status 400
```

After:

```ruby
IEX::Resources::Chart.get('MSFT', '1d', chart_interval: 10, invalid_option: 'foo')
> IEX::Errors::ClientError: "invalidOption" is not allowed
```

See [#9](https://github.com/dblock/iex-ruby-client/pull/9) for more information.
