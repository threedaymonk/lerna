module Lerna
  class Display
    INTERNAL_TYPES = %w[ LVDS ]
    DIGITAL_TYPES = %w[ LVDS DP HDMI DVI ]

    def self.parse(line)
      name, status, = line.split(/\s/)
      new(name, status == 'connected')
    end

    def initialize(name, connected)
      @name = name
      @connected = connected
    end

    attr_reader :name

    def connected?
      @connected
    end

    def type
      name.sub(/-?\d+$/, '')
    end

    def internal?
      INTERNAL_TYPES.include?(type)
    end

    def external?
      !internal?
    end

    def digital?
      DIGITAL_TYPES.include?(type)
    end

    def analog?
      !digital?
    end

    def ==(other)
      [name, connected?] == [other.name, other.connected?]
    end
  end
end
