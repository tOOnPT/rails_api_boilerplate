Rails.application.routes.draw do
  # Define your routes here ;)

  # Home - Healthcheck
  get "healthcheck", to: "healthcheck#show"
  root to: "healthcheck#show"
end
