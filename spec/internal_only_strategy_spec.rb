require 'lerna/strategies/internal_only'

RSpec.describe Lerna::Strategies::InternalOnly do
  subject {
    described_class.new(displays)
  }

  context 'when only the internal display is connected' do
    let(:displays) {
      [
        double(name: 'LVDS1', internal?: true, connected?: true),
        double(name: 'DP1', internal?: false, connected?: false)
      ]
    }

    it { is_expected.to be_applicable }

    it 'configures the internal display' do
      expect(subject.configure).to eq(%w[
        --output LVDS1 --auto
      ])
    end

    it 'disables all other displays' do
      expect(subject.preconfigure).to eq(%w[
        --output DP1 --off
      ])
    end
  end

  context 'when an internal and an external display are connected' do
    let(:displays) {
      [
        double(name: 'LVDS1', internal?: true, connected?: true),
        double(name: 'DP1', internal?: false, connected?: true)
      ]
    }

    it { is_expected.not_to be_applicable }
  end
end
