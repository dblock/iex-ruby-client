RSpec.shared_context 'client' do |opts|
  let(:client) { IEX::Api::Client.new(opts || {}) }
  before do
    IEX::Api.config.reset!
  end
end
