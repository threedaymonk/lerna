require 'lerna/strategies/external_digital_only'

RSpec.describe Lerna::Strategies::ExternalDigitalOnly do
  subject {
    described_class.new(displays)
  }

  context 'when only one external digital display is connected' do
    let(:displays) {
      [
        double(name: 'LVDS1', external?: false,
               connected?: true, digital?: true),
        double(name: 'DP1', external?: true,
               connected?: true, digital?: true),
        double(name: 'DP2', external?: true,
               connected?: false, digital?: true),
        double(name: 'VGA1', external?: true,
               connected?: false, digital?: false)
      ]
    }

    it { is_expected.to be_applicable }

    it 'configures the connected external display' do
      expect(subject.configuration).to eq(%w[
        --output LVDS1 --off
        --output DP2   --off
        --output VGA1  --off
        --output DP1   --auto
      ])
    end
  end

  context 'when no external digital display is connected' do
    let(:displays) {
      [
        double(name: 'LVDS1', external?: false,
               connected?: true, digital?: true),
        double(name: 'DP1', external?: true,
               connected?: false, digital?: true),
        double(name: 'DP2', external?: true,
               connected?: false, digital?: true),
        double(name: 'VGA1', external?: true,
               connected?: true, digital?: false)
      ]
    }

    it { is_expected.not_to be_applicable }
  end
end
