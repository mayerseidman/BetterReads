class MemberPopulator
	def initialize(group)
		@group = group
	end

	def populate
		user_ids.map do |u|
			profile_url = "https://www.goodreads.com/user/show/#{u}.xml?key=01QcdA8pt51gOUi4UJj6A"
			dic = Nokogiri::HTML(open(profile_url))
			name = dic.xpath("//name")[0].text
			city = dic.xpath("//location").text
			member = Member.find_or_create_by(goodreads_id: u)
			if member.location && member.location.city == city
				#do nothing
			else
				member.location = Location.for_city(city)
			end
			member.name = name
			member.save!
		end
	end

	private
		def user_ids
			url = "https://www.goodreads.com/group/#{@group.goodreads_id}/members?format=xml&key='UpIly3BURwhZ52tmj4ag'" # &page=#{n}
			doc = Nokogiri::HTML(open(url))
			doc.xpath("//user/id").map(&:text) 
		end 
end