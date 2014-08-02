require_relative 'deflater_base'

module Paperclip
  module Processors
    class Deflater < DeflaterBase
      def initialize(file, options = {}, attachment = nil)
        super
        @deflate_options = @options[:deflate_options] || {}
      end

      private

      def make_impl
        level       = @deflate_options[:level]
        window_bits = @deflate_options[:window_bits]
        memlevel    = @deflate_options[:memlevel]
        strategy    = @deflate_options[:strategy]

        dst = create_tempfile
        zd = Zlib::Deflate.new(level, window_bits, memlevel, strategy)
        dst.write zd.deflate(@file.read)
        zd.close
        dst.flush
        dst.rewind

        dst
      end
    end
  end
end
