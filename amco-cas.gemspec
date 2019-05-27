$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "amco/cas/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "amco-cas"
  spec.version     = Amco::Cas::VERSION
  spec.authors     = ["Erick Fabian"]
  spec.email       = ["amcoit@amcoonline.net"]
  spec.homepage    = "https://github.com/amco/amco-cas"
  spec.summary     = %q{Abstracts away basic authentication and filtering logic to be used with amco id.}
  spec.description = %q{}
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 4.2.11.1"
  spec.add_dependency "redis-rails"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
