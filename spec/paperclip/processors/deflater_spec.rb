# encoding: utf-8
require 'spec_helper'

describe Paperclip::Processors::Deflater do
  let(:attachment) { double }
  let(:options) { {} }
  let(:file) { test_file }
  subject { Paperclip::Processors::Deflater.new(file, options, attachment) }
  before do
    allow(attachment).to receive(:instance_read).with(:no_deflate)
  end
  describe "private methods" do
    describe "#make_impl" do
      it "deflates the file" do
        dst = subject.make
        data = dst.read
        expect(data.unpack('H*').first).to eq("x\x9C".unpack('H*').first)
      end
    end
  end
end
