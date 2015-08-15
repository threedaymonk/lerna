require 'lerna/strategy'
require 'lerna/strategies/dual_external'
require 'lerna/strategies/dual_portrait'
require 'lerna/strategies/external_digital_only'
require 'lerna/strategies/internal_only'

Lerna::Strategy.register(
  'dual-external' => Lerna::Strategies::DualExternal,
  'dual-portrait' => Lerna::Strategies::DualPortrait,
  'external-only' => Lerna::Strategies::ExternalDigitalOnly,
  'internal-only' => Lerna::Strategies::InternalOnly
)
