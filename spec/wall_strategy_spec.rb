require 'lerna/strategies/wall'

RSpec.describe Lerna::Strategies::Wall do
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

    it 'configures the connected external displays in alphanumeric order' do
      expect(subject.configure).to eq(%w[
        --output DP1 --auto --rotate normal
        --output DP2 --auto --rotate normal --right-of DP1
      ])
    end

    it 'disables all other displays' do
      expect(subject.preconfigure).to eq(%w[
        --output LVDS1 --off
        --output VGA1  --off
      ])
    end
  end

  context 'when three external digital displays are connected' do
    let(:displays) {
      [
        double(name: 'LVDS1', external?: false,
               connected?: true, digital?: true),
        double(name: 'HDMI1', external?: true,
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

    it 'configures the connected external displays in alphanumeric order' do
      expect(subject.configure).to eq(%w[
        --output DP1   --auto --rotate normal
        --output DP2   --auto --rotate normal --right-of DP1
        --output HDMI1 --auto --rotate normal --right-of DP2
      ])
    end

    it 'disables all other displays' do
      expect(subject.preconfigure).to eq(%w[
        --output LVDS1 --off
        --output VGA1  --off
      ])
    end
  end
end
