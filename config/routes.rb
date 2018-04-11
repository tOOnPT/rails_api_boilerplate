Rails.application.routes.draw do
  # Define your routes here ;)


  # API Documentation
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  # Home - Healthcheck
  get "healthcheck", to: "healthcheck#show"
  root to: "healthcheck#show"
end
