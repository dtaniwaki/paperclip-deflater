require 'spec_helper'

describe Paperclip::Processors::DeflaterBase do
  let(:attachment) { double }
  let(:no_deflate) { nil }
  let(:options) { {} }
  let(:file) { test_file }
  subject { Paperclip::Processors::DeflaterBase.new(file, options, attachment) }
  before do
    allow(attachment).to receive(:instance_read).with(:no_deflate).and_return(no_deflate)
  end
  describe "#make" do
    context "no_deflate setting is true" do
      let(:no_deflate) { true }
      it "returns original" do
        expect(subject.make).to eq(file)
      end
    end
  end
  describe "private methods" do
    describe "#make_impl" do
      it "raises an exception" do
        expect{ subject.send(:make_impl) }.to raise_error(NotImplementedError)
      end
    end
    describe "create_tempfile" do
      it "returns a tempfile" do
        f = subject.send(:create_tempfile)
        expect(f).to be_a Tempfile
        expect(f.binmode?).to be true
      end
    end
  end
end
