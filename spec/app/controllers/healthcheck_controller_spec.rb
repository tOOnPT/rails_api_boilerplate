require "rails_helper"

describe HealthcheckController, type: :controller do
  describe "#show" do
    context "when all system data is available" do
      it "returns system check data" do
        get :show, format: :json

        expect(response).to have_http_status(:ok)
        expect(response_json.keys).to include(:name, :system)
      end
    end
  end
end
