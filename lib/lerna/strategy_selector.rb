require 'lerna/strategies'

module Lerna
  class StrategySelector
    def initialize(registry = Strategy.registry)
      @registry = registry
    end

    def call(strategy_names, displays)
      strategies = strategy_names.map { |s| @registry.fetch(s) }
      strategies.map { |s| s.new(displays) }.find(&:applicable?)
    end
  end
end
