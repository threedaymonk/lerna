require 'lerna/strategy'

module Lerna
  module Strategies
    class DualExternal < Strategy
      def applicable?
        wanted_displays.length == 2
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
        [
          '--output', names[0], '--auto',
          '--output', names[1], '--auto', '--right-of', names[0]
        ]
      end
    end
  end
end
