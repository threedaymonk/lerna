require 'lerna/strategies/wall'

module Lerna
  module Strategies
    class PortraitWall < Wall
    private

      def configure_one(name)
        ['--output', name, '--auto', '--rotate', 'left']
      end
    end
  end
end
