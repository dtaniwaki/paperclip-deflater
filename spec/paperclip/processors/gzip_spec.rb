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
    describe "#make_impl" do
      shared_examples "deflate" do
        it "deflates the file" do
          dst = subject.make
          data = dst.read
          expect(data[0..3]).to eq(result1)
          # data[4..7] is modified time and it changes
          expect(data[8..-1]).to eq(result2)
        end
      end
      let(:result1) { "\u001F\x8B\b\u0000" }
      let(:result2) { "\u0000\u0003+I-.\xE1\u0002\u0000\xC65\xB9;\u0005\u0000\u0000\u0000" }
      include_examples "deflate"
      context "level gzip_options" do
        let(:result2) { "\u0002\u0003+I-.\xE1\u0002\u0000\xC65\xB9;\u0005\u0000\u0000\u0000" }
        let(:options) { {gzip_options: {level: Zlib::BEST_COMPRESSION}} }
        include_examples "deflate"
      end
    end
  end
end
