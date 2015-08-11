require 'lerna/display_enumerator'

module Lerna
  class State
    def initialize(enumerator = DisplayEnumerator.new)
      @enumerator = enumerator
    end

    attr_reader :displays

    def scan!
      @previous_displays = @displays
      @displays = @enumerator.call
    end

    def changed?
      @displays != @previous_displays
    end
  end
end
