require 'lerna/strategy'

module Lerna
  module Strategies
    class ExternalDigitalOnly < Strategy
      def applicable?
        winner
      end

      def configuration
        [].tap { |conf|
          disconnected = displays - [winner]
          disconnected.each do |d|
            conf << '--output' << d.name << '--off'
          end
          conf << '--output' << winner.name << '--auto'
        }
      end

    private

      def winner
        displays.select(&:connected?).find { |d| d.external? && d.digital? }
      end
    end
  end
end
