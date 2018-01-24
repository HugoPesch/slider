$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "slider/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "slider"
  s.version     = Slider::VERSION
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Slider."
  s.description = "TODO: Description of Slider."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.10"

  s.add_development_dependency "sqlite3"
end
