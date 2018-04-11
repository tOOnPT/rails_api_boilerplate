require "swagger_helper"

describe "Healthcheck" do
  path "/" do
    get "Calls API healthcheck endpoint" do
      tags "healthcheck"
      produces "application/json"

      response "200", "request Ok" do
        schema type: :object,
               properties: {
                 name: { type: :string },
                 system: {
                   type: :object,
                   properties: {
                     ruby: { type: :string },
                     rails: { type: :string },
                     db: { type: :string }
                   }
                 }
               }

        run_test!
      end

      response 429, "too many requests" do
        schema "$ref": "#/definitions/error"
      end

      response "200", "Healthcheck" do
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          response_json = JSON.parse(response.body, symbolize_names: true)
          expect(response_json.keys).to include(:name, :system)
          expect(response_json[:name]).to eq("rails_api_boilerplate.rb")
        end
      end
    end
  end
end
