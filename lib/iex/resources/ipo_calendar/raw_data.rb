require 'date'

module IEX
  module Resources
    module IPOCalendar
      class RawData < Resource
        property 'symbol', from: 'Symbol'
        property 'company_name', from: 'companyName'
        property 'expected_date', from: 'expectedDate', transform_with: ->(v) { Date.parse(v) }
        property 'lead_underwriters', from: 'leadUnderwriters'
        property 'underwriters'
        property 'company_counsel', from: 'companyCounsel'
        property 'underwriter_counsel', from: 'underwriterCounsel'
        property 'auditor'
        property 'market'
        property 'cik'
        property 'address'
        property 'city'
        property 'state'
        property 'zip'
        property 'phone'
        property 'ceo'
        property 'employees'
        property 'url'
        property 'status'
        property 'shares_offered', from: 'sharesOffered'
        property 'price_low', from: 'priceLow'
        property 'price_low_dollar', from: 'priceLow', with: ->(v) { Resources::Base.to_dollar(amount: v) }
        property 'price_high', from: 'priceHigh'
        property 'price_high_dollar', from: 'priceHigh', with: ->(v) { Resources::Base.to_dollar(amount: v) }
        property 'offer_amount', from: 'offerAmount'
        property 'total_expenses', from: 'totalExpenses'
        property 'total_expenses_dollar', from: 'totalExpenses', with: ->(v) { Resources::Base.to_dollar(amount: v) }
        property 'shares_over_alloted', from: 'sharesOverAlloted'
        property 'shareholder_shares', from: 'shareholderShares'
        property 'shares_outstanding', from: 'sharesOutstanding'
        property 'lockup_period_expiration', from: 'lockupPeriodExpiration', transform_with: ->(v) { v.nil? || v.empty? ? v : Date.parse(v) }
        property 'quiet_period_expiration', from: 'quietPeriodExpiration', transform_with: ->(v) { v.nil? || v.empty? ? v : Date.parse(v) }
        property 'revenue'
        property 'revenue_dollar', from: 'revenue', with: ->(v) { Resources::Base.to_dollar(amount: v) }
        property 'net_income', from: 'netIncome'
        property 'net_income_dollar', from: 'netIncome', with: ->(v) { Resources::Base.to_dollar(amount: v) }
        property 'total_assets', from: 'totalAssets'
        property 'total_assets_dollar', from: 'totalAssets', with: ->(v) { Resources::Base.to_dollar(amount: v) }
        property 'total_liabilities', from: 'totalLiabilities'
        property 'total_liabilities_dollar', from: 'totalLiabilities', with: ->(v) { Resources::Base.to_dollar(amount: v) }
        property 'stockholder_equity', from: 'stockholderEquity'
        property 'stockholder_equity_dollar', from: 'stockholderEquity', with: ->(v) { Resources::Base.to_dollar(amount: v) }
        property 'company_description', from: 'companyDescription'
        property 'business_description', from: 'businessDescription'
        property 'use_of_proceeds', from: 'useOfProceeds'
        property 'competition'
        property 'amount'
        property 'amount_dollar', from: 'amount', with: ->(v) { Resources::Base.to_dollar(amount: v) }
        property 'percent_offered', from: 'percentOffered'
      end
    end
  end
end
