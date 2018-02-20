class HealthcheckController < ApplicationController
  def show
    render json: system_check
  end

  private

  def system_check
    {
      name: "rails_api_boilerplate.rb",
      system: {
        ruby: `ruby -v`.strip,
        rails: `rails -v`.strip,
        db: `pg_config --version`.strip
      }
    }
  end
end
