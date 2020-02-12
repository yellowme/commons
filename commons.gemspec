$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'commons/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'commons_yellowme'
  spec.version     = Commons::VERSION
  spec.date        = `git log -1 --format="%at" | xargs -I{} date +%Y-%m-%d`
  spec.summary     = "Commons is Yellowme's Rails APIs utilities gem"
  spec.description = "Commons is Yellowme's Rails APIs utilities gem"
  spec.authors     = ['Yellowme']
  spec.email       = 'hola@yellowme.mx'
  spec.homepage    = 'https://github.com/yellowme/commons'
  spec.license     = 'MIT'

  spec.files       = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  spec.add_dependency 'active_model_serializers', '~> 0.10.10'
  spec.add_dependency 'dry-validation'
  spec.add_dependency 'json', '~> 2.0'
  spec.add_dependency 'jwt'
  spec.add_dependency 'phonelib', '~> 0.6.29'
  spec.add_dependency 'rails', '~> 5.2'
  spec.add_dependency 'strip_attributes'

  spec.add_development_dependency 'factory_bot_rails', '~> 5.1.1'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'sqlite3'
end
