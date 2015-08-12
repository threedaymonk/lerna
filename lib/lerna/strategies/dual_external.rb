require 'lerna/strategy'

module Lerna
  module Strategies
    class DualExternal < Strategy
      def applicable?
        wanted_displays.length == 2
      end

      def configuration
        [].tap { |conf|
          disconnected = displays - wanted_displays
          disconnected.each do |d|
            conf << '--output' << d.name << '--off'
          end
          conf << '--output' << wanted_displays[0].name << '--auto'
          conf << '--output' << wanted_displays[1].name << '--auto' <<
            '--right-of' << wanted_displays[0].name
        }
      end

    private

      def wanted_displays
        displays.
          select(&:connected?).
          select { |d| d.external? && d.digital? }.
          sort_by(&:name)
      end
    end
  end
end
