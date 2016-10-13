require File.expand_path('../lib/paperclip/deflater/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "paperclip-deflater"
  gem.version     = Paperclip::Deflater::VERSION
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ["Daisuke Taniwaki"]
  gem.email       = ["daisuketaniwaki@gmail.com"]
  gem.homepage    = "https://github.com/dtaniwaki/paperclip-deflater"
  gem.summary     = "Deflate Processor for Paperclip"
  gem.description = "Deflate Processor for Paperclip"
  gem.license     = "MIT"
  gem.required_ruby_version = '~> 2.1'

  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency "paperclip", ">= 3.4"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", ">= 3.0"
  gem.add_development_dependency "coveralls"
end
