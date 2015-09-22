class Location < ActiveRecord::Base
	def self.for_city(city) 
		lat, lng = Geocoder.coordinates(city)

		# randomize
		lng = (
			lng.to_s[0..-4] + 
			4.times.map { rand(0..9) }.join
		).to_f

		Location.create!(latitude: lat, longitude: lng, city: city)
	end
end
