require 'lerna/strategy'

module Lerna
  module Strategies
    class Wall < Strategy
      def applicable?
        wanted_displays.length >= 2
      end

      def configuration
        disconnected_configuration + connected_configuration
      end

    private

      def wanted_displays
        displays.
          select(&:connected?).
          select { |d| d.external? && d.digital? }.
          sort_by(&:name)
      end

      def disconnected_configuration
        disconnected = displays - wanted_displays
        disconnected.flat_map { |d|
          ['--output', d.name, '--off']
        }
      end

      def connected_configuration
        names = wanted_displays.map(&:name)
        leftmost = configure_one(names.first)
        names.each_cons(2).inject(leftmost) { |a, (l, r)|
          a + configure_one(r) + ['--right-of', l]
        }
      end

      def configure_one(name)
        ['--output', name, '--auto', '--rotate', 'normal']
      end
    end
  end
end
