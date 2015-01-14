# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/gitlab/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-gitlab"
  spec.version       = Omniauth::GitLab::VERSION
  spec.authors       = ["Achilleas Pipinellis"]
  spec.email         = ["axilleas@axilleas.me"]
  spec.summary       = %q{OmniAuth strategy for GitLab}
  spec.description   = %q{OmniAuth strategy for GitLab}
  spec.homepage      = "https://gitlab.com/gitlab-org/omniauth-gitlab"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'omniauth', '~> 1.0'
  spec.add_dependency 'omniauth-oauth2', '~> 1.0'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
