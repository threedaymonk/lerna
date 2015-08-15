module Lerna
  class Strategy
    def self.registry
      @registry ||= {}
    end

    def self.register(names_and_classes)
      registry.merge!(names_and_classes)
    end

    def initialize(displays)
      @displays = displays
    end

  private

    attr_reader :displays
  end
end
