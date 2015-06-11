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
      context "gzip failed to close" do
        before do
          @error = RuntimeError.new "error"
          @writer = {}
          allow(Zlib::GzipWriter).to receive(:new).and_return @writer
          allow(@writer).to receive(:write).and_return nil
        end

        it "raises an error to close" do
          expect(@writer).to receive(:close).and_raise @error
          expect {
            subject.make
          }.to raise_error @error
        end
      end
      context "gzip failed to write" do
        before do
          @error1 = RuntimeError.new "error1"
          @error2 = RuntimeError.new "error2"
          @writer = {}
          allow(Zlib::GzipWriter).to receive(:new).and_return @writer
          allow(@writer).to receive(:write).and_raise @error1
        end

        it "does not raise an error to close" do
          expect(@writer).to receive(:close).and_raise @error2
          expect {
            subject.make
          }.to raise_error @error1
        end
      end
    end
  end
end
