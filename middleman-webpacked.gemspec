# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'middleman-webpacked/version'

Gem::Specification.new do |s|
  s.name        = "middleman-webpacked"
  s.version     = MiddlemanWebpacked::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Aotokitsuruya"]
  s.email       = ["contact@frost.tw"]
  s.homepage    = "https://github.com/elct9620/middleman-webpacked"
  s.summary     = %q{Enable webpack for your middleman project eaiser}
  s.description = %q{Enable webpack for your middleman project eaiser}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 4.2.1"])

  # Additional dependencies
  # s.add_runtime_dependency("gem-name", "gem-version")
end
