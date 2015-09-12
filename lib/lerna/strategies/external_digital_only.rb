require 'lerna/strategy'

module Lerna
  module Strategies
    class ExternalDigitalOnly < Strategy
      def applicable?
        winner
      end

      def preconfigure
        disconnected = displays - [winner]
        disconnected.flat_map { |d| ['--output', d.name, '--off'] }
      end

      def configure
        ['--output', winner.name, '--auto']
      end

    private

      def winner
        displays.select(&:connected?).find { |d| d.external? && d.digital? }
      end
    end
  end
end
