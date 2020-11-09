module IEX
  module Resources
    class CashFlow < Resource
      property 'report_date', from: 'reportDate'
      property 'fiscal_date', from: 'fiscalDate'
      property 'currency'
      property 'net_income', from: 'netIncome'
      property 'net_income_dollar', from: 'netIncome', with: ->(v) { to_dollar(amount: v) }
      property 'depreciation'
      property 'depreciation_dollar', from: 'depreciation', with: ->(v) { to_dollar(amount: v) }
      property 'changes_in_receivables', from: 'changesInReceivables'
      property 'changes_in_receivables_dollar', from: 'changesInReceivables', with: ->(v) { to_dollar(amount: v) }
      property 'changes_in_inventories', from: 'changesInInventories'
      property 'changes_in_inventories_dollar', from: 'changesInInventories', with: ->(v) { to_dollar(amount: v) }
      property 'cash_change', from: 'cashChange'
      property 'cash_change_dollar', from: 'cashChange', with: ->(v) { to_dollar(amount: v) }
      property 'cash_flow', from: 'cashFlow'
      property 'cash_flow_dollar', from: 'cashFlow', with: ->(v) { to_dollar(amount: v) }
      property 'capital_expenditures', from: 'capitalExpenditures'
      property 'capital_expenditures_dollar', from: 'capitalExpenditures', with: ->(v) { to_dollar(amount: v) }
      property 'investments'
      property 'investments_dollar', from: 'investments', with: ->(v) { to_dollar(amount: v) }
      property 'investing_activity_other', from: 'investingActivityOther'
      property 'investing_activity_other_dollar', from: 'investingActivityOther', with: ->(v) { to_dollar(amount: v) }
      property 'total_investing_cash_flows', from: 'totalInvestingCashFlows'
      property 'total_investing_cash_flows_dollar', from: 'totalInvestingCashFlows', with: ->(v) { to_dollar(amount: v) }
      property 'dividends_paid', from: 'dividendsPaid'
      property 'dividends_paid_dollar', from: 'dividendsPaid', with: ->(v) { to_dollar(amount: v) }
      property 'net_borrowings', from: 'netBorrowings'
      property 'net_borrowings_dollar', from: 'netBorrowings', with: ->(v) { to_dollar(amount: v) }
      property 'other_financing_cash_flows', from: 'otherFinancingCashFlows'
      property 'other_financing_cash_flows_dollar', from: 'otherFinancingCashFlows', with: ->(v) { to_dollar(amount: v) }
      property 'cash_flow_financing', from: 'cashFlowFinancing'
      property 'cash_flow_financing_dollar', from: 'cashFlowFinancing', with: ->(v) { to_dollar(amount: v) }
      property 'exchange_rate_effect', from: 'exchangeRateEffect'
      property 'exchange_rate_effect_dollar', from: 'exchangeRateEffect', with: ->(v) { to_dollar(amount: v) }

      def initialize(data = {})
        super
      end
    end
  end
end
