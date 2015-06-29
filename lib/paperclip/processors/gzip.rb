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
          while chunk = @file.read(16 * 1024) do
            gz.write chunk
          end
        rescue ::Exception => e
          gz.close rescue nil
          raise e
        end
        gz.close
        @file.rewind
        dst.open

        dst
      end
    end
  end
end
