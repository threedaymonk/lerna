require 'lerna/display_enumerator'

RSpec.describe Lerna::DisplayEnumerator do
  subject {
    described_class.new.current(xrandr_output)
  }

  context 'laptop with one external HDMI connected' do
    let(:xrandr_output) {
      <<END
Screen 0: minimum 320 x 200, current 1920 x 1200, maximum 32767 x 32767
LVDS1 connected (normal left inverted right x axis y axis)
   1366x768       60.0 +
   1360x768       59.8     60.0
   1024x768       60.0
   800x600        60.3     56.2
   640x480        59.9
VGA1 disconnected (normal left inverted right x axis y axis)
HDMI1 connected 1920x1200+0+0 (normal left inverted right x axis y axis) 518mm x 324mm
   1920x1200      60.0*+
   1600x1200      60.0
   1680x1050      59.9
   1280x1024      60.0
   1280x960       60.0
   1024x768       60.0
   800x600        60.3
   640x480        60.0
   720x400        70.1
DP1 disconnected (normal left inverted right x axis y axis)
HDMI2 disconnected (normal left inverted right x axis y axis)
HDMI3 disconnected (normal left inverted right x axis y axis)
DP2 disconnected (normal left inverted right x axis y axis)
DP3 disconnected (normal left inverted right x axis y axis)
VIRTUAL1 disconnected (normal left inverted right x axis y axis)
END
    }

    it 'reports nine displays' do
      expect(subject.length).to eq(9)
    end

    it 'reports display names' do
      expect(subject.map(&:name)).to eq(%w[
        LVDS1 VGA1 HDMI1 DP1 HDMI2 HDMI3 DP2 DP3 VIRTUAL1
      ])
    end

    it 'reports connection status' do
      expect(subject.map(&:connected?)).to eq([
        true, false, true, false, false, false, false, false, false
      ])
    end
  end
end
