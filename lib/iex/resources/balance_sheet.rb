module IEX
  module Resources
    class BalanceSheet < Resource
      property 'report_date', from: 'reportDate'
      property 'fiscal_date', from: 'fiscalDate'
      property 'currency'
      property 'current_cash', from: 'currentCash'
      property 'current_cash_dollar', from: 'currentCash', with: ->(v) { to_dollar(amount: v) }
      property 'short_term_investments', from: 'shortTermInvestments'
      property 'short_term_investments_dollar', from: 'shortTermInvestments', with: ->(v) { to_dollar(amount: v) }
      property 'receivables'
      property 'receivables_dollar', from: 'receivables', with: ->(v) { to_dollar(amount: v) }
      property 'inventory'
      property 'inventory_dollar', from: 'inventory', with: ->(v) { to_dollar(amount: v) }
      property 'other_current_assets', from: 'otherCurrentAssets'
      property 'other_current_assets_dollar', from: 'otherCurrentAssets', with: ->(v) { to_dollar(amount: v) }
      property 'current_assets', from: 'currentAssets'
      property 'current_assets_dollar', from: 'currentAssets', with: ->(v) { to_dollar(amount: v) }
      property 'long_term_investments', from: 'longTermInvestments'
      property 'long_term_investments_dollar', from: 'longTermInvestments', with: ->(v) { to_dollar(amount: v) }
      property 'property_plant_equipment', from: 'propertyPlantEquipment'
      property 'property_plant_equipment_dollar', from: 'propertyPlantEquipment', with: ->(v) { to_dollar(amount: v) }
      property 'goodwill'
      property 'goodwill_dollar', from: 'goodwill', with: ->(v) { to_dollar(amount: v) }
      property 'intangible_assets', from: 'intangibleAssets'
      property 'intangible_assets_dollar', from: 'intangibleAssets', with: ->(v) { to_dollar(amount: v) }
      property 'other_assets', from: 'otherAssets'
      property 'other_assets_dollar', from: 'otherAssets', with: ->(v) { to_dollar(amount: v) }
      property 'total_assets', from: 'totalAssets'
      property 'total_assets_dollar', from: 'totalAssets', with: ->(v) { to_dollar(amount: v) }
      property 'accounts_payable', from: 'accountsPayable'
      property 'accounts_payable_dollar', from: 'accountsPayable', with: ->(v) { to_dollar(amount: v) }
      property 'current_long_term_debt', from: 'currentLongTermDebt'
      property 'current_long_term_debt_dollar', from: 'currentLongTermDebt', with: ->(v) { to_dollar(amount: v) }
      property 'other_current_liabilities', from: 'otherCurrentLiabilities'
      property 'other_current_liabilities_dollar', from: 'otherCurrentLiabilities', with: ->(v) { to_dollar(amount: v) }
      property 'total_current_liabilities', from: 'totalCurrentLiabilities'
      property 'total_current_liabilities_dollar', from: 'totalCurrentLiabilities', with: ->(v) { to_dollar(amount: v) }
      property 'long_term_debt', from: 'longTermDebt'
      property 'long_term_debt_dollar', from: 'longTermDebt', with: ->(v) { to_dollar(amount: v) }
      property 'other_liabilities', from: 'otherLiabilities'
      property 'other_liabilities_dollar', from: 'otherLiabilities', with: ->(v) { to_dollar(amount: v) }
      property 'minority_interest', from: 'minorityInterest'
      property 'minority_interest_dollar', from: 'minorityInterest', with: ->(v) { to_dollar(amount: v) }
      property 'total_liabilities', from: 'totalLiabilities'
      property 'total_liabilities_dollar', from: 'totalLiabilities', with: ->(v) { to_dollar(amount: v) }
      property 'common_stock', from: 'commonStock'
      property 'retained_earnings', from: 'retainedEarnings'
      property 'retained_earnings_dollar', from: 'retainedEarnings', with: ->(v) { to_dollar(amount: v) }
      property 'treasury_stock', from: 'treasuryStock'
      property 'treasury_stock_dollar', from: 'treasuryStock', with: ->(v) { to_dollar(amount: v) }
      property 'capital_surplus', from: 'capitalSurplus'
      property 'capital_surplus_dollar', from: 'capitalSurplus', with: ->(v) { to_dollar(amount: v) }
      property 'shareholder_equity', from: 'shareholderEquity'
      property 'shareholder_equity_dollar', from: 'shareholderEquity', with: ->(v) { to_dollar(amount: v) }
      property 'net_tangible_assets', from: 'netTangibleAssets'
      property 'net_tangible_assets_dollar', from: 'netTangibleAssets', with: ->(v) { to_dollar(amount: v) }
    end
  end
end
