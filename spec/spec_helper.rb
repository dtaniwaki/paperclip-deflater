require 'rubygems'
require 'simplecov'
require 'coveralls'
Coveralls.wear!

SimpleCov.start do
  add_filter 'spec/'
end

require 'paperclip-deflater'

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
end

