module IEX
  module Resources
    class LargestTrades < Resource
      property 'price'
      property 'size'
      property 'time'
      property 'time_label', from: 'timeLabel'
      property 'venue'
      property 'venue_name', from: 'venueName'
    end
  end
end
