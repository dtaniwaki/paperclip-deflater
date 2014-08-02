require 'paperclip'
require 'paperclip/processors/deflater'
require 'paperclip/processors/gzip'

Paperclip.configure do |c|
  c.register_processor :deflater, Paperclip::Processors::Deflater
  c.register_processor :gzip, Paperclip::Processors::Gzip
end
