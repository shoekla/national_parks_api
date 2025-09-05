module Api
  module V1
    class AlertsController < ApplicationController
      def index
        park = Park.find_by!(code: params[:park_code])

        alerts = park.alerts

        render json: alerts.as_json(
          only: [ :title, :description, :category, :last_indexed_date, :properties ]
        )
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Park not found" }, status: :not_found
      end
    end
  end
end
