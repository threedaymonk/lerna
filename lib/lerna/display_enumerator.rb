require 'lerna/display'

module Lerna
  class DisplayEnumerator
    def call(xrandr_output = `LC_ALL=C xrandr`)
      xrandr_output.
        scan(/^(?:[A-Z\-]+\d+) (?:dis)?connected/).
        map { |line| Display.parse(line) }
    end
  end
end
