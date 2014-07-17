$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "apidocs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "apidocs"
  s.version = Apidocs::VERSION
  s.authors = ["Hubert Łępicki", "Dominika Kruk", "Vladimir Motsak"]
  s.email = ["hubert.lepicki@gmail.com", "vmotsak@gmail.com"]
  s.homepage = "http://github.com/hubertlepicki/apidocs"
  s.summary = "On Fly RDoc generation"
  s.description = "Rails engine that will generate and serve docs for your APIs if you documented your controllers using RDoc"
  s.license = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "README.md"]

  s.add_dependency "rails", ">= 3.2.0"
  s.add_dependency "rdoc", ">= 4.0.0"
  s.add_dependency "jquery-rails"
  s.add_dependency "bootstrap-sass"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "poltergeist"
  s.add_development_dependency "selenium-webdriver" # I just like to sometimes see the tests running
  s.add_development_dependency "pry"
  s.add_development_dependency "jquery-rails"
end
