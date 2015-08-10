module Lerna
  class Display
    INTERNAL_TYPES = %w[ LVDS ]

    def self.parse(line)
      name, status, = line.split(/\s/)
      new(name, status)
    end

    def initialize(name, status)
      @name = name
      @status = status
    end

    attr_reader :name

    def connected?
      @status == 'connected'
    end

    def type
      name.sub(/-?\d+$/, '')
    end

    def internal?
      INTERNAL_TYPES.include?(type)
    end
  end
end
