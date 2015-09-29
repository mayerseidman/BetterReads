class MemberPopulator
	def initialize(group)
		@group = group
	end

	def populate
		user_ids.map do |u|
			profile_url = "https://www.goodreads.com/user/show/#{u}.xml?key=01QcdA8pt51gOUi4UJj6A"
			profile_contents = Net::HTTP.get(URI.parse(profile_url))
			dic = Nokogiri::HTML(profile_contents)
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
			unless @group.members.include?(member)
				@group.members << member
			end
		end
		@group.status = "populated"
		@group.save!
	end

	private
		def user_ids
			url = "https://www.goodreads.com/group/#{@group.goodreads_id}/members?format=xml&key='UpIly3BURwhZ52tmj4ag'" # &page=#{n}
			member_data =  Net::HTTP.get(URI.parse(url))
			doc = Nokogiri::HTML(member_data)
			doc.xpath("//user/id").map(&:text) 
		end 
end