require 'lerna/strategy_selector'

RSpec.describe Lerna::StrategySelector do
  subject {
    described_class.new(
      'strategy_a' => strategy_a_class,
      'strategy_b' => strategy_b_class
    )
  }

  let(:strategy_a_class) { double('StrategyA', new: strategy_a) }
  let(:strategy_b_class) { double('StrategyB', new: strategy_b) }
  let(:strategy_a) { double('strategy_a', applicable?: false) }
  let(:strategy_b) { double('strategy_b', applicable?: true) }
  let(:displays) { double('displays') }

  it 'instantiates each class with the displays' do
    expect(strategy_a_class).to receive(:new).with(displays).and_return(strategy_a)
    expect(strategy_b_class).to receive(:new).with(displays).and_return(strategy_b)
    subject.call(%w[ strategy_a strategy_b ], displays)
  end

  it 'returns the first applicable instance' do
    expect(subject.call(%w[ strategy_a strategy_b ], displays)).to eq(strategy_b)
  end

  it 'returns nil if there is no applicable instance' do
    expect(subject.call(%w[ strategy_a ], displays)).to be_nil
  end
end
