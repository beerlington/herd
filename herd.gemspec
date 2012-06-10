# -*- encoding: utf-8 -*-
require File.expand_path('../lib/herd/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Peter Brown"]
  gem.email         = ["github@lette.us"]
  gem.description   = %q{Inspired by Backbone.js, this utility lets you define collections for better separation of concerns}
  gem.summary       = %q{Organize ActiveRecord collection functionality into separate classes}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "herd"
  gem.require_paths = ["lib"]
  gem.version       = Herd::VERSION

  gem.add_dependency('rails', '>= 3.0')

  gem.add_development_dependency('rspec-rails', '~> 2.10.0')
  gem.add_development_dependency('sqlite3', '~> 1.3.6')

end
