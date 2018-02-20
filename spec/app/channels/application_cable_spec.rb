require "rails_helper"

describe ApplicationCable do
  context "with default connection" do
    it "new" do
      expect(described_class::Connection).to respond_to(:new)
    end
  end

  context "with default channel" do
    it "new" do
      expect(described_class::Channel).to respond_to(:new)
    end
  end
end
