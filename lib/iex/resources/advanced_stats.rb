module IEX
  module Resources
    class AdvancedStats < Resource
      property 'total_cash', from: 'totalCash'
      property 'total_cash_dollars', from: 'totalCash', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'current_debt', from: 'currentDebt'
      property 'current_debt_dollars', from: 'currentDebt', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'revenue'
      property 'revenue_dollars', from: 'revenue', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'gross_profit', from: 'grossProfit'
      property 'gross_profit_dollar', from: 'grossProfit', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'total_revenue', from: 'totalRevenue'
      property 'total_revenue_dollar', from: 'totalRevenue', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'ebitda', from: 'EBITDA'
      property 'ebitda_dollar', from: 'EBITDA', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'revenue_per_share', from: 'revenuePerShare'
      property 'revenue_per_share_dollars', from: 'revenuePerShare', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'revenue_per_employee', from: 'revenuePerEmployee'
      property 'revenue_per_employee_dollar', from: 'revenuePerEmployee', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'debt_to_equity', from: 'debtToEquity'
      property 'profit_margin', from: 'profitMargin'
      property 'enterprise_value', from: 'enterpriseValue'
      property 'enterprise_value_dollar', from: 'enterpriseValue', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'enterprise_value_to_revenue', from: 'enterpriseValueToRevenue'
      property 'price_to_sales', from: 'priceToSales'
      property 'price_to_sales_dollar', from: 'priceToSales', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'price_to_book', from: 'priceToBook'
      property 'forward_pe_ratio', from: 'forwardPERatio'
      property 'avg_30_volume', from: 'avg30Volume'
      property 'peg_ratio', from: 'pegRatio'
      property 'beta'
 
      def initialize(data = {})
        super
      end
    end
  end
end
