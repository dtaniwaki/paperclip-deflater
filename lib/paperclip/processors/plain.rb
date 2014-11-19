require_relative 'deflater_base'

module Paperclip
  module Processors
    class Plain < DeflaterBase
      def make
        dst = create_tempfile
        dst.write @file.read
        @file.rewind
        dst.flush
        dst.rewind
        dst
      end
    end
  end
end
