# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tencent_weibo/version'

Gem::Specification.new do |spec|
  spec.name          = "tencent_weibo"
  spec.version       = TencentWeibo::Version
  spec.authors       = ["gary.zeng"]
  spec.email         = ["gary.zeng@suryani.cn"]
  spec.description   = %q{tencent_weibo is a Ruby gem that provides a wrapper for interacting with tencent weibo API}
  spec.summary       = %q{A oauth2 gem for tencent microblog}
  spec.homepage      = "http://www.suryani.cn"
  spec.license       = "MIT"

  spec.files         = Dir.glob("lib/**/*.rb")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency 'oauth2', "~> 0.9.1"
  spec.add_runtime_dependency 'hashie', "~> 2.0.4"
  spec.add_runtime_dependency 'multi_json'  , "~> 1.7.2"
  spec.add_runtime_dependency 'rest-client', "~> 1.6.7"
end
