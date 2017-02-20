source 'https://rubygems.org'

gem "gem-release"
gem "pry"

ruby_version = RUBY_VERSION
paperclip_version = ENV['PAPERCLIP_VERSION']

gem "paperclip", "~> #{paperclip_version}" if paperclip_version

gem "activesupport", "< 5.0.0" if ruby_version =~ /^2\.1\./

gemspec
