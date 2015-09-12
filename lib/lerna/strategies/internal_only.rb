require 'lerna/strategy'

module Lerna
  module Strategies
    class InternalOnly < Strategy
      def applicable?
        displays.select(&:connected?).all?(&:internal?)
      end

      def preconfigure
        displays.reject(&:connected?).flat_map { |d|
          ['--output', d.name, '--off']
        }
      end

      def configure
        displays.select(&:connected?).flat_map { |d|
          ['--output', d.name, '--auto']
        }
      end
    end
  end
end
