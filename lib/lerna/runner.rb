require 'lerna/strategy_selector'
require 'lerna/state'

module Lerna
  class Runner
    def initialize(logger:, strategies:, system:, state: State.new,
                   strategy_selector: StrategySelector.new)
      @logger = logger
      @strategies = strategies
      @system = system
      @state = state
      @strategy_selector = strategy_selector
    end

    def run
      state.scan!
      return unless state.changed?

      logger.debug state_summary
      strategy = find_strategy
      if strategy
        logger.info "Using #{strategy.class}"
        apply_strategy strategy
      else
        logger.warn 'No applicable strategy found'
      end
    end

  private

    attr_reader :state, :strategy_selector, :strategies, :logger

    def state_summary
      state.displays.
        map { |d| "#{d.name}#{d.connected? ? '*' : ''}" }.
        join(' ')
    end

    def find_strategy
      strategy_selector.call(strategies, state.displays)
    end

    def apply_strategy(strategy)
      system 'xrandr', *strategy.preconfigure
      system 'xrandr', *strategy.configure
      system 'xset dpms force on'
    end

    def system(*args)
      @system.call(*args)
    end
  end
end
