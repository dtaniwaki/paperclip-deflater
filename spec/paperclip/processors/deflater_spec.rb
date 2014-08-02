require 'spec_helper'

describe Paperclip::Processors::Deflater do
  let(:attachment) { double }
  let(:should_deflate) { true }
  let(:options) { {} }
  let(:file) { Tempfile.new('paperclip-processors-deflater') }
  subject { Paperclip::Processors::Deflater.new(file, options, attachment) }
  before do
    allow(attachment).to receive(:instance_read).with(:deflate).and_return(should_deflate)
    file.write 'test'
    file.rewind
  end
  it "deflates the file" do
    dst = subject.make
    out = File.open(dst.path).read
    expect(out).to eq("x\x9C")
  end
  context "disable deflate" do
    let(:should_deflate) { false }
    it "does not deflate the file" do
      dst = subject.make
      out = File.open(dst.path).read
      expect(out).to eq("test")
    end
  end
end
