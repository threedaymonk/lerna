require 'lerna/display'

RSpec.describe Lerna::Display do
  subject {
    described_class.parse(xrandr_line)
  }

  context 'a connected LVDS display' do
    let(:xrandr_line) {
      'LVDS1 connected (normal left inverted right x axis y axis)'
    }

    it { is_expected.to be_connected }
    it { is_expected.to be_internal }
    it { is_expected.to be_digital }

    it 'has a name' do
      expect(subject.name).to eq('LVDS1')
    end

    it 'has a type' do
      expect(subject.type).to eq('LVDS')
    end
  end

  context 'a connected HDMI display' do
    let(:xrandr_line) {
      'HDMI1 connected 1920x1200+0+0 (normal left inverted right x axis y axis) 518mm x 324mm'
    }

    it { is_expected.to be_connected }
    it { is_expected.not_to be_internal }
    it { is_expected.to be_digital }

    it 'has a name' do
      expect(subject.name).to eq('HDMI1')
    end

    it 'has a type' do
      expect(subject.type).to eq('HDMI')
    end
  end

  context 'a disconnected DisplayPort display' do
    let(:xrandr_line) {
      'DP1 disconnected (normal left inverted right x axis y axis)'
    }

    it { is_expected.not_to be_connected }
    it { is_expected.not_to be_internal }
    it { is_expected.to be_digital }

    it 'has a name' do
      expect(subject.name).to eq('DP1')
    end

    it 'has a type' do
      expect(subject.type).to eq('DP')
    end
  end

  context 'a disconnected VGA display' do
    let(:xrandr_line) {
      'VGA1 disconnected (normal left inverted right x axis y axis)'
    }

    it { is_expected.not_to be_digital }
  end

  context 'a display with a hyphen in the type' do
    let(:xrandr_line) {
      'S-video disconnected (normal left inverted right x axis y axis)'
    }

    it 'has a name' do
      expect(subject.name).to eq('S-video')
    end

    it 'has a type' do
      expect(subject.type).to eq('S-video')
    end
  end

  context 'a display with a hyphen before the number' do
    let(:xrandr_line) {
      'DVI-0 disconnected (normal left inverted right x axis y axis)'
    }

    it 'has a name' do
      expect(subject.name).to eq('DVI-0')
    end

    it 'has a type' do
      expect(subject.type).to eq('DVI')
    end
  end

  context 'equality' do
    it 'is true if displays have the same name and connectivity' do
      a = described_class.new('HDMI1', true)
      b = described_class.new('HDMI1', true)
      expect(a).to eq(b)
    end

    it 'is false if displays have a different name' do
      a = described_class.new('HDMI1', true)
      b = described_class.new('VGA1', true)
      expect(a).not_to eq(b)
    end

    it 'is false if displays have different connectivity' do
      a = described_class.new('HDMI1', true)
      b = described_class.new('HDMI1', false)
      expect(a).not_to eq(b)
    end
  end
end
