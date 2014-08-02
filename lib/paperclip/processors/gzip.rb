require_relative 'deflater_base'

module Paperclip
  module Processors
    class Gzip < DeflaterBase
      def initialize(file, options = {}, attachment = nil)
        super
        @gzip_options = @options[:gzip_options] || {}
      end

      private

      def make_impl
        level       = @gzip_options[:level]
        strategy    = @gzip_options[:strategy]

        dst = create_tempfile
        gz = Zlib::GzipWriter.new(dst, level, strategy)
        gz.write(@file.read)
        gz.close
        dst.open

        dst
      end
    end
  end
end
