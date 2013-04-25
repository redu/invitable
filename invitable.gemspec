# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "invitable/version"

Gem::Specification.new do |s|
  s.name        = "invitable"
  s.version     = Invitable::VERSION
  s.authors     = ["Tarcisio Coutinho"]
  s.email       = ["tcs5cin@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Generic invitation manager}
  s.description = %q{Generic email invitation manager}

  s.rubyforge_project = "invitable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.0"
  s.add_development_dependency "factory_girl", "~> 2.2"
  s.add_development_dependency "shoulda-matchers"

  s.add_runtime_dependency "rails", "~>3.2.13"
end
