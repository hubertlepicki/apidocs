$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "apidocs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "apidocs"
  s.version     = Apidocs::VERSION
  s.authors     = ["Vladimir Motsak"]
  s.email       = ["vmotsak@gmail.com"]
  s.homepage    = "http://github.com"
  s.summary     = "On Fly RDoc generation"
  s.description = "On Fly RDoc generation"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.1"

  s.add_development_dependency "sqlite3"
end
