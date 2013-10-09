require "ultimate_weather_forecasts"

class HomeController < ApplicationController

  include UltimateWeatherForecasts
  
  #def under_construction
  #end
  
  def index
    @weather = whats_the_weather_in("Dallas")
  end
  
  
end
