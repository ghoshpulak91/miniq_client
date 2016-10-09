# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'miniq_client/version'

Gem::Specification.new do |gem|
  gem.name          = "miniq_client"
  gem.version       = MiniQClientVersion::VERSION
  gem.authors       = ["Pulak Ghosh"]
  gem.email         = ["ghosh.pulak91@gmail.com"]
  gem.description   = %q{This is MiniQ client}
  gem.summary       = %q{MiniQ Ruby Client}
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|specs|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "minitest"
end
