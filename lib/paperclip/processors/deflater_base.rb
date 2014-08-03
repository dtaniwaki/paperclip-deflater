require 'paperclip/processor'
require 'zlib'
require 'tempfile'

module Paperclip
  module Processors
    class DeflaterBase < ::Paperclip::Processor
      def initialize(file, options = {}, attachment = nil)
        super
        @format          = @options[:format]
        @current_format  = File.extname(@file.path)
        @basename        = File.basename(@file.path, @current_format)
      end

      def make
        return @file if @attachment.instance_read(:no_deflate) == true
        make_impl
      end

      private

      def make_impl
        raise NotImplementedError
      end

      def create_tempfile
        f = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
        f.binmode
        f
      end
    end
  end
end
