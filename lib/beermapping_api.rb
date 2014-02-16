class BeermappingApi

  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, :expires_in => (1.week.from_now - Time.now).to_i ) { fetch_places_in(city) }

  end

  private

  def self.fetch_places_in(city)
    url = get_url

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response['bmp_locations']['location']

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    @places = places.inject([]) do | set, place |
      set << Place.new(place)
    end

  end

  def get_url
    if use_heroku_cache
      url = 'http://stark-oasis-9187.herokuapp.com/api/'
    else
      url = "http://beermapping.com/webservice/loccity/#{api_key}/"
    end
  end

  def self.use_heroku_cache
    false
  end

  def self.api_key
    'd2bbe218faf28bc0a65fc760e77eedf2'
  end
end