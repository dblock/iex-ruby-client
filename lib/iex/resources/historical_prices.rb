module IEX
  module Resources
    class HistorialPrices < Resource
      property 'date'
      property 'open'
      property 'open_dollar', from: 'open', with: ->(v) { to_dollar(amount: v, ignore_cents: false) }
      property 'close'
      property 'close_dollar', from: 'close', with: ->(v) { to_dollar(amount: v, ignore_cents: false) }
      property 'high'
      property 'high_dollar', from: 'high', with: ->(v) { to_dollar(amount: v, ignore_cents: false) }
      property 'low'
      property 'low_dollar', from: 'low', with: ->(v) { to_dollar(amount: v, ignore_cents: false) }
      property 'volume'
      property 'u_open', from: 'uOpen'
      property 'u_open_dollar', from: 'uOpen', with: ->(v) { to_dollar(amount: v, ignore_cents: false) }
      property 'u_close', from: 'uClose'
      property 'u_close_dollar', from: 'uClose', with: ->(v) { to_dollar(amount: v, ignore_cents: false) }
      property 'u_low', from: 'uLow'
      property 'u_low_dollar', from: 'uLow', with: ->(v) { to_dollar(amount: v, ignore_cents: false) }
      property 'u_high', from: 'uHigh'
      property 'u_high_dollar', from: 'uHigh', with: ->(v) { to_dollar(amount: v, ignore_cents: false) }
      property 'u_volume', from: 'uVolume'
      property 'change'
      property 'change_percent', from: 'changePercent'
      property 'change_percent_s', from: 'changePercent', with: ->(v) { percentage_to_string(v) }
      property 'label'
      property 'change_over_time', from: 'changeOverTime'
      property 'change_over_time_s', from: 'changeOverTime', with: ->(v) { percentage_to_string(v) }
    end
  end
end
