# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "huginn_freme_enrichment_agents"
  spec.version       = '0.1'
  spec.authors       = ["Dominik Sander"]
  spec.email         = ["git@dsander.de"]

  spec.summary       = %q{Agents for doing natural language processing using the FREME APIs.}
  spec.description   = %q{Write a longer description or delete this line.}

  spec.homepage      = "https://github.com/kreuzwerker/DKT.huginn_freme_enrichment_agents"

  spec.license       = "Apache License 2.0"


  spec.files         = Dir['LICENSE.txt', 'lib/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = Dir['spec/**/*.rb']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "huginn_agent"
end
