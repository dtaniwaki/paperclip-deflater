require 'spec_helper'

describe Paperclip::Processors::Plain do
  let(:attachment) { double }
  let(:no_deflate) { nil }
  let(:options) { {} }
  let(:file) { test_file }
  subject { Paperclip::Processors::Plain.new(file, options, attachment) }
  before do
    allow(attachment).to receive(:instance_read).with(:no_deflate).and_return(no_deflate)
  end
  describe "#make" do
    it "returns the file" do
      expect(subject.make).not_to be file
      expect(subject.make.read).to eq test_file.read
    end
  end
end
