module Lerna
  class Strategy
    def initialize(displays)
      @displays = displays
    end

  private

    attr_reader :displays
  end
end
