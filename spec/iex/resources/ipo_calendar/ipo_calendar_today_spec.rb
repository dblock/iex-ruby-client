require 'spec_helper'

describe 'IEX::Resources::IPOCalendar.today' do
  context 'today ipos', vcr: { cassette_name: 'ipo_calendar/today-ipos' } do
    subject do
      IEX::Resources::IPOCalendar.today
    end

    let(:raw_data) { subject.raw_data.first }
    let(:view_data) { subject.view_data.first }

    it "retrieves a list of today's IPOs per api response" do
      expect(subject.raw_data.count).to eq 1
      expect(subject.view_data.count).to eq 1
    end

    it 'includes last update date' do
      expect(subject.last_update_date).to eq Date.parse('2018-10-02')
    end

    it 'retrieves IPO fields per api response' do
      expect(raw_data.symbol).to eq 'UPWK'
      expect(raw_data.company_name).to eq 'UPWORK INC.'
      expect(raw_data.expected_date).to eq Date.parse('2018-10-03')
      expect(raw_data.lead_underwriters).to eq ['Citigroup Global Markets Inc', 'Jefferies LLC', 'RBC Capital Markets, LLC']
      expect(raw_data.underwriters).to eq ['JMP Securities LLC', 'Stifel Nicolaus & Company, Incorporated']
      expect(raw_data.company_counsel).to eq ['Fenwick & West LLP']
      expect(raw_data.underwriter_counsel).to eq ['Wilson Sonsini Goodrich & Rosati, P.C.']
      expect(raw_data.auditor).to eq 'Computershare Trust Company, N.A'
      expect(raw_data.market).to eq 'NASDAQ Global Select'
      expect(raw_data.cik).to eq '0001627475'
      expect(raw_data.address).to eq '441 LOGUE AVENUE'
      expect(raw_data.city).to eq 'MOUNTAIN VIEW'
      expect(raw_data.state).to eq 'CA'
      expect(raw_data.zip).to eq '94043'
      expect(raw_data.phone).to eq '650-316-7500'
      expect(raw_data.ceo).to eq 'Stephane Kasriel'
      expect(raw_data.employees).to eq 395
      expect(raw_data.url).to eq 'www.upwork.com'
      expect(raw_data.status).to eq 'Filed'
      expect(raw_data.shares_offered).to eq 12_300_000
      expect(raw_data.price_low).to eq 12
      expect(raw_data.price_high).to eq 14
      expect(raw_data.offer_amount).to eq nil
      expect(raw_data.total_expenses).to eq 6_000_000
      expect(raw_data.shares_over_alloted).to eq 1_844_999
      expect(raw_data.shareholder_shares).to eq 5_481_819
      expect(raw_data.shares_outstanding).to eq 104_079_498
      expect(raw_data.lockup_period_expiration).to eq ''
      expect(raw_data.quiet_period_expiration).to eq ''
      expect(raw_data.revenue).to eq 121_899_000
      expect(raw_data.net_income).to eq 7_196_000 * -1
      expect(raw_data.total_assets).to eq 290_263_000
      expect(raw_data.total_liabilities).to eq 154_388_000
      expect(raw_data.stockholder_equity).to eq 30_611_000 * -1
      expect(raw_data.company_description).to eq 'Our mission is to create economic opportunities so people have better lives...Our telephone &#10; number is (650) 316-7500. Our website address is www.upwork.com.'
      expect(raw_data.business_description).to eq 'Our mission is to create economic opportunities so people have better lives...Our telephone &#10; number is (650) 316-7500. Our website address is www.upwork.com.'
      expect(raw_data.use_of_proceeds).to eq 'We estimate that the net proceeds from the sale by us of 6,818,181 shares of...commercial paper, and guaranteed obligations of the U.S. government.'
      expect(raw_data.competition).to eq 'The market for freelancers and the clients... We believe that we compete favorably with respect to these factors.'
      expect(raw_data.amount).to eq 159_900_000
      expect(raw_data.percent_offered).to eq '11.82'

      expect(view_data.company).to eq 'UPWORK INC.'
      expect(view_data.symbol).to eq 'UPWK'
      expect(view_data.price).to eq '$12.00 - 14.00'
      expect(view_data.shares).to eq '12,300,000'
      expect(view_data.amount).to eq '159,900,000'
      expect(view_data.float).to eq '104,079,498'
      expect(view_data.percent).to eq '11.82%'
      expect(view_data.market).to eq 'NASDAQ Global Select'
      expect(view_data.expected).to eq '2018-10-03'
    end

    it 'also retrieves raw data dollar denominated values' do
      expect(raw_data.price_low_dollar).to eq '$12'
      expect(raw_data.price_high_dollar).to eq '$14'
      expect(raw_data.total_expenses_dollar).to eq '$6,000,000'
      expect(raw_data.revenue_dollar).to eq '$121,899,000'
      expect(raw_data.net_income_dollar).to eq '$-7,196,000'
      expect(raw_data.total_assets_dollar).to eq '$290,263,000'
      expect(raw_data.total_liabilities_dollar).to eq '$154,388,000'
      expect(raw_data.stockholder_equity_dollar).to eq '$-30,611,000'
      expect(raw_data.amount_dollar).to eq '$159,900,000'
    end
  end
end
