lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "method_cache"
  gem.version       = IO.read('VERSION')
  gem.authors       = ["Justin Balthrop", "Scott Steadman"]
  gem.email         = ["git@justinbalthrop.com", "scott.steadman@geni.com"]
  gem.description   = %q{Simple memcache-based memoization library for Ruby}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/geni/method_cache"
  gem.license       = 'MIT'

  gem.add_development_dependency 'dalli'
  gem.add_development_dependency 'method_source'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'shoulda'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = '~> 3.0'
end