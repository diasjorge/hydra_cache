# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hydra_cache/version"

Gem::Specification.new do |s|
  s.name        = "hydra_cache"
  s.version     = HydraCache::VERSION
  s.authors     = ["Jorge Dias", "Albert Llop"]
  s.email       = ["jorge.dias@xing.com", "albert.llop@xing.com"]
  s.homepage    = ""
  s.summary     = %q{Cache support for Hydra}
  s.description = %q{This gem provides a cache mechanism for Hydra to avoid hitting the same request multiple times}

  s.rubyforge_project = "hydra_cache"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rake"

  s.add_development_dependency "minitest"
  s.add_development_dependency "typhoeus"
  s.add_development_dependency "test-construct"
end
