# encoding: utf-8
require 'spec_helper'

describe Paperclip::Processors::Gzip do
  let(:attachment) { double }
  let(:options) { {} }
  let(:file) { test_file }
  subject { Paperclip::Processors::Gzip.new(file, options, attachment) }
  before do
    allow(attachment).to receive(:instance_read).with(:no_deflate)
  end
  describe "private methods" do
    describe "#make" do
      shared_examples "deflate" do
        it "deflates the file" do
          dst = subject.make
          data = dst.read
          # data[4..7] is modified time and it changes
          expect(data.bytes).to match(result)
        end
      end
      let(:result) { [31, 139, 8, 0, anything, anything, anything, anything, 0, 3, 43, 73, 45, 46, 225, 2, 0, 198, 53, 185, 59, 5, 0, 0, 0] }
      include_examples "deflate"
      context "level gzip_options" do
        let(:result) { [31, 139, 8, 0, anything, anything, anything, anything, 2, 3, 43, 73, 45, 46, 225, 2, 0, 198, 53, 185, 59, 5, 0, 0, 0] }
        let(:options) { {gzip_options: {level: Zlib::BEST_COMPRESSION}} }
        include_examples "deflate"
      end
    end
  end
end
