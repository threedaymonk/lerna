require 'lerna/strategies/dual_portrait'

RSpec.describe Lerna::Strategies::DualPortrait do
  subject {
    described_class.new(displays)
  }

  context 'when fewer than two external digital displays are connected' do
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

    it { is_expected.not_to be_applicable }
  end

  context 'when two external digital displays are connected' do
    let(:displays) {
      [
        double(name: 'LVDS1', external?: false,
               connected?: true, digital?: true),
        double(name: 'DP1', external?: true,
               connected?: true, digital?: true),
        double(name: 'DP2', external?: true,
               connected?: true, digital?: true),
        double(name: 'VGA1', external?: true,
               connected?: false, digital?: false)
      ]
    }

    it { is_expected.to be_applicable }

    it 'configures the connected external display' do
      expect(subject.configuration).to eq(%w[
        --output LVDS1 --off
        --output VGA1  --off
        --output DP1   --auto --rotate left
        --output DP2   --auto --rotate left --right-of DP1
      ])
    end
  end
end
