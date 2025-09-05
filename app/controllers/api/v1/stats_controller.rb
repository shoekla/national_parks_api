module Api
  module V1
    class StatsController < ApplicationController
      def index
        total_parks   = Park.count
        total_alerts  = Alert.count

        parks_by_state = Park.all.each_with_object(Hash.new(0)) do |park, counts|
          Array(park.states).each { |state| counts[state] += 1 }
        end
        # sort parks_by_state
        parks_by_state = parks_by_state.sort_by { |state, count| -count }.to_h

        # Sort alerts
        alerts_by_park = Alert.group(:park_id)
                              .count
                              .sort_by { |_park_id, count| -count }
                              .first(5)

        top_parks_by_alerts = alerts_by_park.map do |park_id, count|
          park = Park.find_by(id: park_id)
          { park_code: park&.code, park_name: park&.name, alerts_count: count }
        end

        render json: {
          total_parks: total_parks,
          total_alerts: total_alerts,
          parks_by_state: parks_by_state,
          top_parks_by_alerts: top_parks_by_alerts
        }
      end
    end
  end
end
