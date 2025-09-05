# national_parks_api

## Project Setup
To install the gems and dependencies run the following. Make sure to have cloned the repo and be in the correct directory.
```
bundle install
```
Next setup config/application.yml . Within the `config` directory create a file `application.yml` to store some data that we will use for the national parks api calls.
Your `application.yml` should look like the following (substitute with your own API key).
```
national_parks_parks_url: "https://developer.nps.gov/api/v1/parks"
national_parks_alerts_url: "https://developer.nps.gov/api/v1/alerts"
national_parks_api_key: "YOUR_API_KEY_HERE"
```
Next we need to setup our database. Run the following to create and migrate the local database.
```
bin/rails db:create
bin/rails db:migrate
```
Finally we need to seed our database and fill in data from the national parks api. The `db/seeds.rb` file calls the paginated api and retrieves all parks and alerts records from the api and creates the records/associations in our local database. To populate, run the following:
```
bin/rails db:seed
```
Now you should be setup to run the server and start making requests. You can open the rails console and check that the Park and Alert tables have been populated by running:
```
rails c
    >Park.count
    >Alert.count
```
## Running Automated Spec Tests
I have also included specs for the Park and Alert models, as well as the Park, Alert, and Stat controllers.
To run the specs, run the command
```
bundle exec rspec spec
```
## Stats Api
The stats route will return the total parks, total alerts, parks by state (sorted), and the top parks by alerts (sorted).
