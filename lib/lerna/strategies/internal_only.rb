require 'lerna/strategy'

module Lerna
  module Strategies
    class InternalOnly < Strategy
      def applicable?
        displays.select(&:connected?).all?(&:internal?)
      end

      def configuration
        [].tap { |conf|
          displays.reject(&:connected?).each do |d|
            conf << '--output' << d.name << '--off'
          end
          displays.select(&:connected?).each do |d|
            conf << '--output' << d.name << '--auto'
          end
        }
      end
    end
  end
end
