# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coding_ch_oct_nine/version'

Gem::Specification.new do |spec|
  spec.name          = "coding_ch_oct_nine"
  spec.version       = CodingChOctNine::VERSION
  spec.authors       = ["TheNotary"]
  spec.email         = ["no@email.plz"]

  spec.summary       = %q{coding challenge}
  spec.homepage      = "https://github.com/TheNotary/coding_ch_oct_nine"
  # spec.license       = "MIT" # uncomment and replace with GPLv3, etc.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # spec.add_dependency "bundler", "~> 1.17"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
