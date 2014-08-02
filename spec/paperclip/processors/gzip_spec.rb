# encoding: utf-8
require 'spec_helper'

describe Paperclip::Processors::Gzip do
  let(:attachment) { double }
  let(:should_deflate) { true }
  let(:options) { {} }
  let(:file) { test_file }
  subject { Paperclip::Processors::Gzip.new(file, options, attachment) }
  before do
    allow(attachment).to receive(:instance_read).with(:deflate).and_return(should_deflate)
  end
  describe "private methods" do
    describe "#make_impl" do
      before do
        allow(file).to receive(:mtime).and_return(Time.new(2000, 1, 2, 3, 4, 5))
      end
      it "deflates the file" do
        dst = subject.make
        data = dst.read
        expect(data[0..3]).to eq("\u001F\x8B\b\u0000")
        # data[4..7] is modified time and it changes
        expect(data[8..-1]).to eq("\u0000\u0003+I-.\xE1\u0002\u0000\xC65\xB9;\u0005\u0000\u0000\u0000")
      end
    end
  end
end
