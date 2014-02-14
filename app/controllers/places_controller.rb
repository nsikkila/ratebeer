class PlacesController < ApplicationController


  def index

  end

  def search

    url = ""
    if use_cache
      url = 'http://stark-oasis-9187.herokuapp.com/api/'
    else
      api_key = 'd2bbe218faf28bc0a65fc760e77eedf2'
      url = "http://beermapping.com/webservice/loccity/#{api_key}/"
    end
    response = HTTParty.get(url+'helsinki')
    places_from_api = response.parsed_response['bmp_locations']['location']
    @places = [ Place.new(places_from_api.first)]

    render :index

  end

  private
  def use_cache
    false
  end

end