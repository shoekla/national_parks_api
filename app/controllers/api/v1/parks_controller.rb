module Api
  module V1
    class ParksController < ApplicationController
      def index
        parks = Park.all

        # Filter by state if given
        if params[:state].present?
          parks = parks.where("? = ANY (states)", params[:state])
        end

        # Paginate
        parks = parks.page(params[:page]).per(params[:per_page] || 10)

        render json: {
          current_page: parks.current_page,
          total_pages: parks.total_pages,
          total_count: parks.total_count,
          parks: parks.as_json(only: [ :code, :name, :description, :states, :properties ])
        }
      end

      def show
        park = Park.find_by!(code: params[:code])

        render json: park.as_json(
          only: [ :code, :name, :description, :states, :properties ]
        )
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Park not found" }, status: :not_found
      end
    end
  end
end
