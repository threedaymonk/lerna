require File.expand_path("../lib/lerna/version", __FILE__)

spec = Gem::Specification.new do |s|
  s.name              = "lerna"
  s.version           = Lerna::VERSION
  s.summary           = "Linux display manager"
  s.description       = "Tame multi-head displays"
  s.author            = "Paul Battley"
  s.email             = "pbattley@gmail.com"
  s.homepage          = "http://github.com/threedaymonk/lerna"
  s.license           = "MIT"

  s.has_rdoc          = true

  s.files             = %w(Rakefile README.md) + Dir.glob("{bin,test,lib}/**/*")
  s.executables       = Dir["bin/**"].map { |f| File.basename(f) }

  s.require_paths     = ["lib"]

  s.required_ruby_version = '>= 2.1.0'

  s.add_development_dependency "rake", "~> 0"
  s.add_development_dependency "rspec", "~> 3"
  s.add_development_dependency "rubocop", "~> 0.30.0"
end
