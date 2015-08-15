require 'lerna/strategies/dual_external'

module Lerna
  module Strategies
    class DualPortrait < DualExternal
    private

      def connected_configuration
        names = wanted_displays.map(&:name)
        [
          '--output', names[0], '--auto', '--rotate', 'left',
          '--output', names[1], '--auto', '--rotate', 'left',
          '--right-of', names[0]
        ]
      end
    end
  end
end
