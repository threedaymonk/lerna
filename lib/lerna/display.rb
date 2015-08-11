module Lerna
  class Display
    INTERNAL_TYPES = %w[ LVDS ]

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

    def ==(other)
      [name, connected?] == [other.name, other.connected?]
    end
  end
end
