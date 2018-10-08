require 'spec_helper'

describe 'IEX::Resources::IPOCalendar.upcoming' do
  context 'upcoming ipos', vcr: { cassette_name: 'ipo_calendar/upcoming-ipos' } do
    subject do
      IEX::Resources::IPOCalendar.upcoming
    end

    let(:raw_data_first) { subject.raw_data.first }
    let(:view_data_first) { subject.view_data.first }

    it 'retrieves a list of upcoming IPOs per api response' do
      expect(subject.raw_data.count).to eq 2
      expect(subject.view_data.count).to eq 2
    end

    it 'retrieves IPO fields per api response' do
      expect(raw_data_first.symbol).to eq 'GH'
      expect(raw_data_first.company_name).to eq 'GUARDANT HEALTH, INC.'
      expect(raw_data_first.expected_date).to eq Date.parse('2018-10-04')
      expect(raw_data_first.lead_underwriters).to eq ['BofA Merrill Lynch', 'J.P. Morgan Securities LLC']
      expect(raw_data_first.underwriters).to eq ['Cowen and Company, LLC', 'Leerink Partners LLC', 'William Blair and Co., L.L.C.']
      expect(raw_data_first.company_counsel).to eq ['Latham & Watkins LLP']
      expect(raw_data_first.underwriter_counsel).to eq ['Cooley LLP']
      expect(raw_data_first.auditor).to eq 'Computershare Trust Company, N.A'
      expect(raw_data_first.market).to eq 'NASDAQ Global Select'
      expect(raw_data_first.cik).to eq '0001576280'
      expect(raw_data_first.address).to eq '505 PENOBSCOT DR.'
      expect(raw_data_first.city).to eq 'REDWOOD CITY'
      expect(raw_data_first.state).to eq 'CA'
      expect(raw_data_first.zip).to eq '94063'
      expect(raw_data_first.phone).to eq '855-698-8887'
      expect(raw_data_first.ceo).to eq 'Helmy Eltoukhy'
      expect(raw_data_first.employees).to eq 348
      expect(raw_data_first.url).to eq 'www.guardanthealth.com'
      expect(raw_data_first.status).to eq 'Filed'
      expect(raw_data_first.shares_offered).to eq 12_500_000
      expect(raw_data_first.price_low).to eq 15
      expect(raw_data_first.price_high).to eq 17
      expect(raw_data_first.offer_amount).to eq 200_000_000
      expect(raw_data_first.total_expenses).to eq 4_241_500
      expect(raw_data_first.shares_over_alloted).to eq 1_875_000
      expect(raw_data_first.shareholder_shares).to eq 25_000
      expect(raw_data_first.shares_outstanding).to eq 83_557_281
      expect(raw_data_first.lockup_period_expiration).to eq Date.parse('2019-04-04')
      expect(raw_data_first.quiet_period_expiration).to eq Date.parse('2019-04-04')
      expect(raw_data_first.revenue).to eq 36_074_000
      expect(raw_data_first.net_income).to eq 35_483_000 * -1
      expect(raw_data_first.total_assets).to eq 362_847_000
      expect(raw_data_first.total_liabilities).to eq 45_066_000
      expect(raw_data_first.stockholder_equity).to eq 276_781_000
      expect(raw_data_first.company_description).to eq 'We are a leading precision oncology company focused on helping conquer cancer...Our corporate website is &#10; www.guardanthealth.com.'
      expect(raw_data_first.business_description).to eq 'We are a leading precision oncology company focused on helping conquer cancer...Our corporate website is &#10; www.guardanthealth.com.'
      expect(raw_data_first.use_of_proceeds).to eq 'We estimate the net proceeds from this offering will be approximately $181.8 &#10; million, or $209.7 million...obligations of the U.S. government.'
      expect(raw_data_first.competition).to eq 'Growing understanding of the importance of biomarkers linked with therapy...continue to compete &#10; effectively on each of those layers.'
      expect(raw_data_first.amount).to eq 200_000_000
      expect(raw_data_first.percent_offered).to eq '14.96'

      expect(view_data_first.company).to eq 'GUARDANT HEALTH, INC.'
      expect(view_data_first.symbol).to eq 'GH'
      expect(view_data_first.price).to eq '$15.00 - 17.00'
      expect(view_data_first.shares).to eq '12,500,000'
      expect(view_data_first.amount).to eq '200,000,000'
      expect(view_data_first.float).to eq '83,557,281'
      expect(view_data_first.percent).to eq '14.96%'
      expect(view_data_first.market).to eq 'NASDAQ Global Select'
      expect(view_data_first.expected).to eq '2018-10-04'
    end

    it 'also retrieves raw data dollar denominated values' do
      expect(raw_data_first.price_low_dollar).to eq '$15'
      expect(raw_data_first.price_high_dollar).to eq '$17'
      expect(raw_data_first.total_expenses_dollar).to eq '$4,241,500'
      expect(raw_data_first.revenue_dollar).to eq '$36,074,000'
      expect(raw_data_first.net_income_dollar).to eq '$-35,483,000'
      expect(raw_data_first.total_assets_dollar).to eq '$362,847,000'
      expect(raw_data_first.total_liabilities_dollar).to eq '$45,066,000'
      expect(raw_data_first.stockholder_equity_dollar).to eq '$276,781,000'
      expect(raw_data_first.amount_dollar).to eq '$200,000,000'
    end
  end
end
