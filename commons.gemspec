$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "commons/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "commons_yellowme"
  spec.version     = Commons::VERSION
  spec.date        = '2019-12-10'
  spec.summary     = "Commons is Yellowme's Rails APIs utilities gem"
  spec.description = "Commons is Yellowme's Rails APIs utilities gem"
  spec.files       = [
                       "lib/commons.rb",
                       "spec/support/shared-examples/capitalizable.rb",
                       "spec/support/shared-examples/undestroyable.rb",
                       "spec/support/shared-examples/stripable.rb"
                     ]
  spec.authors     = ["Yellowme"]
  spec.email       = 'hola@yellowme.mx'
  spec.homepage    = 'https://github.com/yellowme/commons-rails'
  spec.license      = 'MIT'

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.1"
  spec.add_dependency 'json', '~> 1.8'
  spec.add_dependency "active_model_serializers", "~> 0.10.10"
  spec.add_dependency "strip_attributes"
  spec.add_dependency "jwt"
  spec.add_dependency "dry-validation"
  spec.add_dependency "phonelib", "~> 0.6.29"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "factory_bot_rails", "~> 5.1.1"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "simplecov"
end
