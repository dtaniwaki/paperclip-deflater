require_relative 'deflater_base'

module Paperclip
  module Processors
    class Gzip < DeflaterBase
      def initialize(file, options = {}, attachment = nil)
        super
        @gzip_options = @options[:gzip_options] || {}
      end

      def make
        level       = @gzip_options[:level]
        strategy    = @gzip_options[:strategy]

        dst = create_tempfile
        begin
          gz = Zlib::GzipWriter.new(dst, level, strategy)
          gz.write(@file.read)
        ensure
          gz.close
        end
        dst.open

        dst
      end
    end
  end
end
