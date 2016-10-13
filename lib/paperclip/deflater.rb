require 'active_support/core_ext/module/delegation'
require 'paperclip'
require 'paperclip/processors/plain'
require 'paperclip/processors/deflater'
require 'paperclip/processors/gzip'

Paperclip.configure do |c|
  c.register_processor :plain, Paperclip::Processors::Plain
  c.register_processor :deflater, Paperclip::Processors::Deflater
  c.register_processor :gzip, Paperclip::Processors::Gzip
end
