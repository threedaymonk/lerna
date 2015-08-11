require 'lerna/state'

RSpec.describe Lerna::State do
  subject { described_class.new(enumerator) }

  let(:enumerator) { -> { enumerations.shift } }

  context 'after the first scan' do
    let(:enumerations) {
      [
        [Lerna::Display.new('HDMI1', false)]
      ]
    }

    before do
      subject.scan!
    end

    it { is_expected.to be_changed }

    it 'lists the current displays' do
      expect(subject.displays).to eq([Lerna::Display.new('HDMI1', false)])
    end
  end

  context 'when the connections have changed' do
    let(:enumerations) {
      [
        [Lerna::Display.new('HDMI1', false)],
        [Lerna::Display.new('HDMI1', true)]
      ]
    }

    before do
      2.times do
        subject.scan!
      end
    end

    it { is_expected.to be_changed }

    it 'lists the current displays' do
      expect(subject.displays).to eq([Lerna::Display.new('HDMI1', true)])
    end
  end

  context 'when the connections have not changed' do
    let(:enumerations) {
      [
        [Lerna::Display.new('HDMI1', true)],
        [Lerna::Display.new('HDMI1', true)]
      ]
    }

    before do
      2.times do
        subject.scan!
      end
    end

    it { is_expected.not_to be_changed }

    it 'lists the current displays' do
      expect(subject.displays).to eq([Lerna::Display.new('HDMI1', true)])
    end
  end
end
