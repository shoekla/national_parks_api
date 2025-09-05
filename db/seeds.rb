require 'httparty'

# Clear existing data
Alert.destroy_all
Park.destroy_all

API_KEY = ENV['national_parks_api_key']

def fill_parks
    start = 0
    limit = 50

    loop do
        response = HTTParty.get(ENV['national_parks_parks_url'], query: { limit: limit, start: start, api_key: API_KEY })
        data = response.parsed_response

        break if data['data'].empty?

        create_parks(data["data"])
        start += limit
    end
end

def fill_alerts
    start = 0
    limit = 50

    loop do
        response = HTTParty.get(ENV['national_parks_alerts_url'], query: { limit: limit, start: start, api_key: API_KEY })
        data = response.parsed_response

        break if data['data'].empty?

        create_alerts(data["data"])
        start += limit
    end
end

def create_parks(parks_data)
  parks_data.each do |park_data|
    Park.create!(
        code: park_data["parkCode"],
        name: park_data["fullName"],
        description: park_data["description"],
        states: park_data["states"].split(","),
        national_parks_internal_id: park_data["id"],
        properties: park_data.except("id", "parkCode", "fullName", "description", "states")
    )
  end
end

def create_alerts(alerts_data)
    alerts_data.each do |alert_data|
        park = Park.find_by(code: alert_data["parkCode"])
        if park.nil?
            puts "Warning: Park with code #{alert_data['parkCode']} not found. Skipping alert #{alert_data['id']}."
            next
        end

        Alert.create!(
            park: park,
            title: alert_data["title"],
            description: alert_data["description"],
            category: alert_data["category"],
            last_indexed_date: alert_data["lastIndexedDate"],
            national_parks_internal_id: alert_data["id"],
            properties: alert_data.except("id", "title", "description", "category", "lastIndexedDate", "parkCode")
        )
    end
end

puts 'Seeding Parks...'
fill_parks
puts "Parks seeding completed. Created #{Park.count} parks."
puts 'Seeding Alerts...'
fill_alerts
puts "Alerts seeding completed. Created #{Alert.count} alerts."
