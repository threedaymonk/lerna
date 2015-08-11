module Lerna
  class Strategy
    def self.registry
      @registry ||= {}
    end

    def self.inherited(subclass)
      name = subclass.to_s.split(/::/).last
      hyphenated = name.scan(/[A-Z][a-z_0-9]+/).map(&:downcase).join('-')
      registry[hyphenated] = subclass
    end

    def initialize(displays)
      @displays = displays
    end

  private

    attr_reader :displays
  end
end
