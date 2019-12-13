$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "bestie/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "bestie"
  spec.version     = Bestie::VERSION
  spec.date        = '2019-12-10'
  spec.summary     = "Bestie is Yellowme's Rails APIs utilities gem"
  spec.description = "Bestie is Yellowme's Rails APIs utilities gem"
  spec.files       = [
                       "lib/bestie.rb",
                       "spec/support/shared-examples/capitalizable.rb",
                       "spec/support/shared-examples/undestroyable.rb"
                     ]
  spec.authors     = ["Yellowme"]
  spec.email       = 'hola@yellowme.mx'
  spec.homepage    = 'https://github.com/yellowme/bestie-rails'
  spec.license      = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.1"
  spec.add_dependency "active_model_serializers", "~> 0.10.10"
  spec.add_dependency "strip_attributes"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "factory_bot_rails", "~> 5.1.1"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "simplecov"
end
