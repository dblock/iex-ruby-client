### 1.1.0 (2019/07/08)

* [#55](https://github.com/dblock/iex-ruby-client/pull/55): Add `income` statement API and add `tags` to the `company` - [@bingxie](https://github.com/bingxie).

### 1.0.1 (2019/07/08)

* [#50](https://github.com/dblock/iex-ruby-client/pull/50): Add missing properties for key stats API - [@bingxie](https://github.com/bingxie).
* Fix: `uninitialized constant IEX::Endpoints::Chart::Date (NameError)` - [@dblock](https://github.com/dblock).

### 1.0.0 (2019/04/23)

* [#42](https://github.com/dblock/iex-ruby-client/pull/42): Migrated to the IEX Cloud API - [@bingxie](https://github.com/bingxie).
* [#46](https://github.com/dblock/iex-ruby-client/pull/46): Made client configurable - [@dblock](https://github.com/dblock).

### 0.4.4 (2018/12/27)

* [#39](https://github.com/dblock/iex-ruby-client/pull/39): Remove default range and use iextrading default range 1m instead in `IEX::Api::Dividends` - [@ildarkayumov](https://github.com/ildarkayumov).
* [#37](https://github.com/dblock/iex-ruby-client/pull/37): Add `IEX::Resource::Crypto` - [@rodolfobandeira](https://github.com/rodolfobandeira).
* [#34](https://github.com/dblock/iex-ruby-client/pull/34): Add `IEX::Resource::LargestTrades` - [@gil27](https://github.com/gil27).
* [#32](https://github.com/dblock/iex-ruby-client/pull/32): Add `IEX::Resource::Sectors` - [@gil27](https://github.com/gil27).

### 0.4.3 (2018/08/18)

* [#27](https://github.com/dblock/iex-ruby-client/pull/27): Added `IEX::Resources::Earnings` - [@rodolfobandeira](https://github.com/rodolfobandeira).

### 0.4.2 (2018/08/14)

* [#24](https://github.com/dblock/iex-ruby-client/pull/24): Add danger-toc and danger-changelog - [@rodolfobandeira](https://github.com/rodolfobandeira).
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

* Fix: undefined method > for nil:NilClass error - [@dblock](https://github.com/dblock).

### 0.3.1 (2018/05/23)

* [#3](https://github.com/dblock/iex-ruby-client/issues/3): Fix: do not error on undefined properties - [@dblock](https://github.com/dblock).

### 0.3.0 (2018/05/22)

* Added `IEX::Resources::Chart#get` - [@dblock](https://github.com/dblock).
* Added `IEX::Resources::News#get` - [@dblock](https://github.com/dblock).
* Added `IEX::Resources::Price#get` - [@dblock](https://github.com/dblock).
* Fix: added `IEX::Resources::Quote#extendedPrice` and `IEX::Resources::Quote#extendedPriceTime` - [@dblock](https://github.com/dblock).

### 0.2.0 (2018/03/26)

* Moved `IEX::Quote` into `IEX::Resources::Quote` - [@dblock](https://github.com/dblock).
* Added `IEX::Resources::Company#get` returning company information - [@dblock](https://github.com/dblock).
* Added `IEX::Resources::Quote#latest_update_t` and `IEX::Resources::Quote#iex_last_updated_t` in `Time` format - [@dblock](https://github.com/dblock).

### 0.1.0 (2018/03/23)

* Initial public release - [@dblock](https://github.com/dblock).
