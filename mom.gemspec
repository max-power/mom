# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mom/version"

Gem::Specification.new do |spec|
  spec.name          = "mom"
  spec.version       = Mom::VERSION
  spec.authors       = ["Kevin"]
  spec.email         = ["kevin.melchert@gmail.com"]
  spec.summary       = %q{Mongo Object Mapper}
  spec.description   = %q{The friendly Mongo Object Mapper.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency "mongo", "~> 1.9.2"
  spec.add_dependency "bson_ext"
  spec.add_dependency "mime-types"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
