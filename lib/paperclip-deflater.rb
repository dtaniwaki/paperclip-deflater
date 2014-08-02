require 'paperclip/processors/deflater'

Paperclip.configure do |c|
  c.register_processor :deflater, Paperclip::Processors::Deflater
end
