class Location < ActiveRecord::Base
	def self.randomize_coords(lat, lng)
		lng = (
			lng.to_s[0..-6] + 
			4.times.map { rand(0..9) }.join
		).to_f

		[lat, lng]
	end

	def self.for_city(city) 
		location = Location.find_by_city(city)
		if location 
			return location
		end
		lat, lng = Geocoder.coordinates(city)
		# randomize

		# lng = (
		# 	lng.to_s[0..-4] + 
		# 	4.times.map { rand(0..9) }.join
		# ).to_f

		Location.create!(latitude: lat, longitude: lng, city: city)
	end
end
