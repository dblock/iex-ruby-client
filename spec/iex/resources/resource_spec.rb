require 'spec_helper'

describe IEX::Resources::Resource do
  context 'float number to percent (Positive)' do
    subject do
      IEX::Resources::Resource.float_to_percentage(0.09123)
    end
    it 'converts to percentage' do
      expect(subject).to eq '+9.12%'
    end
  end

  context 'float number to percent (Negative)' do
    subject do
      IEX::Resources::Resource.float_to_percentage(-0.09123)
    end
    it 'converts to percentage' do
      expect(subject).to eq '-9.12%'
    end
  end

  context 'float number to percent (nil)' do
    subject do
      IEX::Resources::Resource.float_to_percentage(nil)
    end
    it 'nil argument does not convert' do
      expect(subject).to eq nil
    end
  end

  context 'float number to percent (0)' do
    subject do
      IEX::Resources::Resource.float_to_percentage(0)
    end
    it 'Zero converts to +0.00%' do
      expect(subject).to eq '+0.00%'
    end
  end

  context 'Unformatted money amount to dollar' do
    subject do
      IEX::Resources::Resource.to_dollar(amount: 123_391)
    end
    it 'converts to dollar' do
      expect(subject).to eq '$123,391'
    end
  end
end
