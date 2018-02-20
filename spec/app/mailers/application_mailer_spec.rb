require "rails_helper"

describe ApplicationMailer do
  context "with default" do
    it "new" do
      expect(described_class).to respond_to(:new)
    end
  end
end
