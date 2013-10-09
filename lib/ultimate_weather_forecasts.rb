require 'json'

module UltimateWeatherForecasts
  attr_reader :city

  def init_city(city_name)
    @city = city_name
  end

  def whats_the_weather_in(city_name)
    init_city(city_name)

    ### curl --include --request GET 'https://george-vustrey-weather.p.mashape.com/api.php?location=Los%20Angeles' --header "X-Mashape-Authorization: rFBqIzLADOL1m04NhhfjoRKZmzTbBCRp"
    response = Unirest::get(
      "https://george-vustrey-weather.p.mashape.com/api.php?location=#{city}",
      {
        "X-Mashape-Authorization" => "rFBqIzLADOL1m04NhhfjoRKZmzTbBCRp"
      }
    )
    Rails.logger.debug "\n\n\n\n response(#{Time.now.strftime('%a')} #{response.raw_body.class}) ===> #{response.raw_body.inspect} \n\n\n\n"

    today_forecast = {}
    JSON.parse(response.raw_body).each do |day_rec|
      if day_rec["day_of_week"].to_s.strip.downcase == Time.now.strftime('%a').strip.downcase
        today_forecast = day_rec
      end
    end

    return today_forecast
  end


end
