module IEX
  module Resources
    module IPOCalendar
      class ViewData < Resource
        property 'company', from: 'Company'
        property 'symbol', from: 'Symbol'
        property 'price', from: 'Price'
        property 'shares', from: 'Shares'
        property 'amount', from: 'Amount'
        property 'float', from: 'Float'
        property 'percent', from: 'Percent'
        property 'market', from: 'Market'
        property 'expected', from: 'Expected'
      end
    end
  end
end
