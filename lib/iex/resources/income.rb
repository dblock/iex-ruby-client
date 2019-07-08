module IEX
  module Resources
    class Income < Resource
      property 'report_date', from: 'reportDate'
      property 'total_revenue', from: 'totalRevenue'
      property 'total_revenue_dollar', from: 'totalRevenue', with: ->(v) { to_dollar(amount: v) }
      property 'cost_of_revenue', from: 'costOfRevenue'
      property 'cost_of_revenue_dollar', from: 'costOfRevenue', with: ->(v) { to_dollar(amount: v) }
      property 'gross_profit', from: 'grossProfit'
      property 'gross_profit_dollar', from: 'grossProfit', with: ->(v) { to_dollar(amount: v) }
      property 'research_and_development', from: 'researchAndDevelopment'
      property 'research_and_development_dollar', from: 'researchAndDevelopment', with: ->(v) { to_dollar(amount: v) }
      property 'selling_general_and_admin', from: 'sellingGeneralAndAdmin'
      property 'selling_general_and_admin_dollar', from: 'sellingGeneralAndAdmin', with: ->(v) { to_dollar(amount: v) }
      property 'operating_expense', from: 'operatingExpense'
      property 'operating_expense_dollar', from: 'operatingExpense', with: ->(v) { to_dollar(amount: v) }
      property 'operating_income', from: 'operatingIncome'
      property 'operating_income_dollar', from: 'operatingIncome', with: ->(v) { to_dollar(amount: v) }
      property 'other_income_expense_net', from: 'otherIncomeExpenseNet'
      property 'other_income_expense_net_dollar', from: 'otherIncomeExpenseNet', with: ->(v) { to_dollar(amount: v) }
      property 'ebit'
      property 'ebit_dollar', from: 'ebit', with: ->(v) { to_dollar(amount: v) }
      property 'interest_income', from: 'interestIncome'
      property 'interest_income_dollar', from: 'interestIncome', with: ->(v) { to_dollar(amount: v) }
      property 'pretax_income', from: 'pretaxIncome'
      property 'pretax_income_dollar', from: 'pretaxIncome', with: ->(v) { to_dollar(amount: v) }
      property 'income_tax', from: 'incomeTax'
      property 'income_tax_dollar', from: 'incomeTax', with: ->(v) { to_dollar(amount: v) }
      property 'minority_interest', from: 'minorityInterest'
      property 'net_income', from: 'netIncome'
      property 'net_income_dollar', from: 'netIncome', with: ->(v) { to_dollar(amount: v) }
      property 'net_income_basic', from: 'netIncomeBasic'
      property 'net_income_basic_dollar', from: 'netIncomeBasic', with: ->(v) { to_dollar(amount: v) }
    end
  end
end
