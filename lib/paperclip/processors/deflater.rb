require 'active_model'
require 'paperclip/processor'
require 'zlib'
require 'tempfile'

module Paperclip
  module Processors
    class Deflater < ::Paperclip::Processor
      VERSION = ::File.read(::File.expand_path('../../../../VERSION', __FILE__)).to_s.strip

      def initialize(file, options = {}, attachment = nil)
        super
        @format          = @options[:format]
        @deflate_options    = @options[:deflate_options] || {}
        @current_format  = File.extname(@file.path)
        @basename        = File.basename(@file.path, @current_format)
      end

      def make
        src = @file

        should_deflate = @attachment.instance_read(:deflate)
        return src if should_deflate == false

        level       = @deflate_options[:level]
        window_bits = @deflate_options[:window_bits]
        memlevel    = @deflate_options[:memlevel]
        strategy    = @deflate_options[:strategy]

        dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
        dst.binmode
        zd = Zlib::Deflate.new(level, window_bits, memlevel, strategy)
        dst.write zd.deflate(src.read)
        dst.flush
        dst.rewind
        zd.close

        dst
      end
    end
  end
end
