Upgrading iex-ruby-client
===========================

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

