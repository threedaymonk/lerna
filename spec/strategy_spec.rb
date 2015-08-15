require 'lerna/strategy'
require 'lerna/strategies/external_digital_only'

RSpec.describe Lerna::Strategy do
  it 'registers subclasses' do
    expect(described_class.registry.fetch('external-only')).
      to eq(Lerna::Strategies::ExternalDigitalOnly)
  end
end
