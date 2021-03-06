$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "slider/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "slider"
  s.version     = Slider::VERSION
  s.authors     = ["HugoPesch, SamSyl"]
  s.email       = ["contact@stock2com.com"]
  s.homepage    = "http://stock2com.com"
  s.summary     = "Slider Engine."
  s.description = "Engine for sliders."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.10"
  s.add_dependency "paperclip", "~> 4.3"
  s.add_dependency "jquery-rails", "~> 4.3", ">= 4.3.1"
  s.add_dependency "dropzonejs-rails", "~> 0.8.2"
  s.add_dependency "sass-rails", "~> 5.0"
  s.add_dependency "image-picker-rails", "~> 0.2.4"

  s.add_development_dependency "byebug", "~> 10.0"
  s.add_development_dependency "mysql2"
end
