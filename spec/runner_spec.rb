require 'lerna/runner'

RSpec.describe Lerna::Runner do
  subject {
    described_class.new(
      logger: logger,
      system: system,
      strategies: strategies,
      state: state,
      strategy_selector: strategy_selector
    )
  }
  let(:logger) { double('logger', debug: nil, info: nil, warn: nil) }
  let(:system) { double('system', call: nil) }
  let(:strategies) { double('strategies') }
  let(:strategy_selector) { double('strategy_selector', call: nil) }

  after do
    subject.run
  end

  context 'when the state has not changed' do
    let(:state) { double('state', scan!: nil, changed?: false) }

    it 'scans' do
      expect(state).to receive(:scan!)
    end

    it 'does nothing' do
      expect(system).not_to receive(:call)
    end
  end

  context 'when the state has changed' do
    let(:state) {
      double('state', scan!: nil, changed?: true, displays: displays)
    }
    let(:displays) {
      [double('display', name: 'ABC1', connected?: true)]
    }

    it 'scans' do
      expect(state).to receive(:scan!)
    end

    it 'asks the strategy_selector for a strategy' do
      expect(strategy_selector).to receive(:call).
        with(strategies, displays).
        and_return(nil)
    end

    context 'when a strategy is found' do
      let(:strategy) {
        double(
          'strategy',
          configure: %w[ --option --another ],
          preconfigure: %w[ --off1 --off2 ]
        )
      }
      let(:strategy_selector) {
        double('strategy_selector', call: strategy)
      }

      it 'calls xrandr with the strategy preconfiguration' do
        expect(system).to receive(:call).
          with('xrandr', '--off1', '--off2')
      end

      it 'calls xrandr with the strategy configuration' do
        expect(system).to receive(:call).
          with('xrandr', '--option', '--another')
      end

      it 'resets dpms' do
        expect(system).to receive(:call).
          with('xset dpms force on')
      end
    end

    context 'when no strategy is found' do
      it 'does nothing' do
        expect(system).not_to receive(:call)
      end
    end
  end
end
