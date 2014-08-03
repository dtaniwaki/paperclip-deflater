require 'paperclip/processor'

module Paperclip
  module Processors
    class Plain < ::Paperclip::Processor
      def initialize(file, options = {}, attachment = nil)
        super
      end

      def make
        @file
      end
    end
  end
end
