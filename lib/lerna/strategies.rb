require 'lerna/strategy'
require 'lerna/strategies/external_digital_only'
require 'lerna/strategies/internal_only'
require 'lerna/strategies/portrait_wall'
require 'lerna/strategies/wall'

Lerna::Strategy.register(
  'external-only' => Lerna::Strategies::ExternalDigitalOnly,
  'internal-only' => Lerna::Strategies::InternalOnly,
  'portrait-wall' => Lerna::Strategies::PortraitWall,
  'wall' => Lerna::Strategies::Wall
)
