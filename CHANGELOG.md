### 1.6.0 (2021/10/17)
* [#110](https://github.com/dblock/iex-ruby-client/pull/110): Drop `money_helper` dependency and utilize `money` gem directly - [@agrberg](https://github.com/agrberg).

### 1.5.0 (2021/08/15)
* [#105](https://github.com/dblock/iex-ruby-client/pull/105): Added support for fetching latest foreign exchange rates - [@mathu97](https://github.com/mathu97).
* [#106](https://github.com/dblock/iex-ruby-client/pull/106): Added support for fetching a single key stat with `key_stat(symbol, stat)` endpoint - [@agrberg](https://github.com/agrberg).
* [#107](https://github.com/dblock/iex-ruby-client/pull/107): Added `./script/console` for ease of local development - [@agrberg](https://github.com/agrberg).

### 1.4.1 (2021/05/15)
* [#103](https://github.com/dblock/iex-ruby-client/pull/103): Added support for fetching symbols for an exchange - [@mathu97](https://github.com/mathu97).
* [#99](https://github.com/dblock/iex-ruby-client/pull/99): Added `image` and `paywalled` to news - [@reddavis](https://github.com/reddavis).
* [#100](https://github.com/dblock/iex-ruby-client/pull/100): Added `language` to news - [@reddavis](https://github.com/reddavis).

### 1.4.0 (2020/11/19)
* [#90](https://github.com/dblock/iex-ruby-client/pull/90): Added documentation for advanced stats and removed `avg_30_Volume` from advanced stats since it is found in key stats - [@tylerhaugen-stanley](https://github.com/tylerhaugen-stanley).
* [#91](https://github.com/dblock/iex-ruby-client/pull/91): Added support for Balance Sheet API endpoint - [@tylerhaugen-stanley](https://github.com/tylerhaugen-stanley).
* [#92](https://github.com/dblock/iex-ruby-client/pull/92): Added support for Cash Flow Statements API endpoint - [@tylerhaugen-stanley](https://github.com/tylerhaugen-stanley).
* [#93](https://github.com/dblock/iex-ruby-client/pull/93): Added `fiscal_date` and `currency` to income statements - [@tylerhaugen-stanley](https://github.com/tylerhaugen-stanley).
* [#94](https://github.com/dblock/iex-ruby-client/pull/94): Added `historical_prices` API endpoint - [@tylerhaugen-stanley](https://github.com/tylerhaugen-stanley).
* [#95](https://github.com/dblock/iex-ruby-client/pull/95): Added all KeyStat properties to AdvancedStats since they are already returned in the API call - [@tylerhaugen-stanley](https://github.com/tylerhaugen-stanley).

### 1.3.0 (2020/10/31)

* [#82](https://github.com/dblock/iex-ruby-client/pull/82): Added `config.referer` to set HTTP `Referer` header. This enables IEX's "Manage domains" domain locking for tokens - [@agrberg](https://github.com/agrberg).
* [#70](https://github.com/dblock/iex-ruby-client/pull/70): Added support for `ref_data_isin` taking a single `String` parameter - [@rodolfobandeira](https://github.com/rodolfobandeira).
* [#84](https://github.com/dblock/iex-ruby-client/pull/84): Added support for Advanced Stats API - [@FanaHOVA](https://github.com/fanahova).
* [#86](https://github.com/dblock/iex-ruby-client/issues/86): Added advanced logger configuration to `config.logger`. Now a hash with keys `:instance, :options, and :proc` can be passed and used directly with Faraday - [@agrberg](https://github.com/agrberg).
* [#88](https://github.com/dblock/iex-ruby-client/pull/88): Updated logger configuration to work like `Config` class and allow attribute and block based configuration - [@agrberg](https://github.com/agrberg).
* [#89](https://github.com/dblock/iex-ruby-client/pull/89): Backfill breaking `Config#logger` setting change from [#88](https://github.com/dblock/iex-ruby-client/pull/88) - [@agrberg](https://github.com/agrberg).

### 1.2.0 (2020/09/01)

* [#78](https://github.com/dblock/iex-ruby-client/pull/78): Added `Quote#extended_change_percent` and `Quote#extended_change_percent_s` properties to Quote - [@reddavis](https://github.com/reddavis).
* [#71](https://github.com/dblock/iex-ruby-client/pull/71): Added `symbols` resource - [@ryosuke-endo](https://github.com/ryosuke-endo).
* [#69](https://github.com/dblock/iex-ruby-client/pull/69): Fixed `ref_data_isin` request - [@bguban](https://github.com/bguban).
* [#72](https://github.com/dblock/iex-ruby-client/pull/72): Cache `Faraday::Connection` for persistent adapters - [@dblock](https://github.com/dblock).

### 1.1.2 (2020/03/25)

* [#68](https://github.com/dblock/iex-ruby-client/pull/68): Fixed `ref_data_isin` request with wrong isin - [@bguban](https://github.com/bguban).
* [#67](https://github.com/dblock/iex-ruby-client/pull/67): Added required ruby version to gemspec - [@wdperson](https://github.com/wdperson).
* [#66](https://github.com/dblock/iex-ruby-client/pull/66): Fixed `KeyStats#week_52_change always` returns nil - [@brunjo](https://github.com/brunjo).
* [#65](https://github.com/dblock/iex-ruby-client/pull/65): Added `stock_market_list` - [@bguban](https://github.com/bguban).
* [#64](https://github.com/dblock/iex-ruby-client/pull/64): Added `ref_data_isin` - [@bguban](https://github.com/bguban).

### 1.1.1 (2020/03/02)

* [#63](https://github.com/dblock/iex-ruby-client/pull/63): Allow direct API calls with support for secret_token - [@bguban](https://github.com/bguban).
* [#61](https://github.com/dblock/iex-ruby-client/pull/61): Fixed income endpoint if the api returns no result - [@brunjo](https://github.com/brunjo).
* [#57](https://github.com/dblock/iex-ruby-client/pull/57): Updated properties for chart api endpoint - [@brunjo](https://github.com/brunjo).

### 1.1.0 (2019/07/08)

* [#55](https://github.com/dblock/iex-ruby-client/pull/55): Added `income` statement API and add `tags` to the `company` - [@bingxie](https://github.com/bingxie).

### 1.0.1 (2019/07/08)

* [#50](https://github.com/dblock/iex-ruby-client/pull/50): Added missing properties for key stats API - [@bingxie](https://github.com/bingxie).
* Fixed `uninitialized constant IEX::Endpoints::Chart::Date (NameError)` - [@dblock](https://github.com/dblock).

### 1.0.0 (2019/04/23)

* [#42](https://github.com/dblock/iex-ruby-client/pull/42): Migrated to the IEX Cloud API - [@bingxie](https://github.com/bingxie).
* [#46](https://github.com/dblock/iex-ruby-client/pull/46): Made client configurable - [@dblock](https://github.com/dblock).

### 0.4.4 (2018/12/27)

* [#39](https://github.com/dblock/iex-ruby-client/pull/39): Remove default range and use iextrading default range 1m instead in `IEX::Api::Dividends` - [@ildarkayumov](https://github.com/ildarkayumov).
* [#37](https://github.com/dblock/iex-ruby-client/pull/37): Added `IEX::Resource::Crypto` - [@rodolfobandeira](https://github.com/rodolfobandeira).
* [#34](https://github.com/dblock/iex-ruby-client/pull/34): Added `IEX::Resource::LargestTrades` - [@gil27](https://github.com/gil27).
* [#32](https://github.com/dblock/iex-ruby-client/pull/32): Added `IEX::Resource::Sectors` - [@gil27](https://github.com/gil27).

### 0.4.3 (2018/08/18)

* [#27](https://github.com/dblock/iex-ruby-client/pull/27): Added `IEX::Resources::Earnings` - [@rodolfobandeira](https://github.com/rodolfobandeira).

### 0.4.2 (2018/08/14)

* [#24](https://github.com/dblock/iex-ruby-client/pull/24): Added danger-toc and danger-changelog - [@rodolfobandeira](https://github.com/rodolfobandeira).
* [#21](https://github.com/dblock/iex-ruby-client/pull/21): Added `IEX::Resources::Dividends` - [@rodolfobandeira](https://github.com/rodolfobandeira).

### 0.4.1 (2018/08/07)

* [#18](https://github.com/dblock/iex-ruby-client/pull/18): Added `IEX::Resources::KeyStats` - [@rodolfobandeira](https://github.com/rodolfobandeira).

### 0.4.0 (2018/07/29)

* [#9](https://github.com/dblock/iex-ruby-client/pull/9): Added `IEX::Errors::ClientError` - [@rodolfobandeira](https://github.com/rodolfobandeira).
* [#10](https://github.com/dblock/iex-ruby-client/pull/10): Added `IEX::Resources::Logo#get` - [@rodolfobandeira](https://github.com/rodolfobandeira).

### 0.3.3 (2018/07/06)

* [#5](https://github.com/dblock/iex-ruby-client/pull/5): Added `IEX::Resources::OHLC#get` - [@jromanovs](https://github.com/jromanovs).
* [#5](https://github.com/dblock/iex-ruby-client/pull/5): Added `IEX::Resources::OHLC#market` - [@jromanovs](https://github.com/jromanovs).

### 0.3.2 (2018/05/26)

* Fixed undefined method > for nil:NilClass error - [@dblock](https://github.com/dblock).

### 0.3.1 (2018/05/23)

* [#3](https://github.com/dblock/iex-ruby-client/issues/3): Fixed do not error on undefined properties - [@dblock](https://github.com/dblock).

### 0.3.0 (2018/05/22)

* Added `IEX::Resources::Chart#get` - [@dblock](https://github.com/dblock).
* Added `IEX::Resources::News#get` - [@dblock](https://github.com/dblock).
* Added `IEX::Resources::Price#get` - [@dblock](https://github.com/dblock).
* Fixed added `IEX::Resources::Quote#extendedPrice` and `IEX::Resources::Quote#extendedPriceTime` - [@dblock](https://github.com/dblock).

### 0.2.0 (2018/03/26)

* Moved `IEX::Quote` into `IEX::Resources::Quote` - [@dblock](https://github.com/dblock).
* Added `IEX::Resources::Company#get` returning company information - [@dblock](https://github.com/dblock).
* Added `IEX::Resources::Quote#latest_update_t` and `IEX::Resources::Quote#iex_last_updated_t` in `Time` format - [@dblock](https://github.com/dblock).

### 0.1.0 (2018/03/23)

* Initial public release - [@dblock](https://github.com/dblock).
