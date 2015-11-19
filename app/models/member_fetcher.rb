class MemberFetcher 
	def initialize(goodreads_id)
		@goodreads_id = goodreads_id
	end

	def member_ids
		page = 1
		results = []
		loop do
			puts "Fetching Page: #{page}, #{@goodreads_id}" 
			member_ids = member_ids_for_page(page)
			break if member_ids.empty?
			results += member_ids
			page += 1
		end
		return results
	end	

	private
		def member_ids_for_page(page_number) 
			url = "https://www.goodreads.com/group/#{@goodreads_id}/members?page=#{page_number}&format=xml&key='UpIly3BURwhZ52tmj4ag'" # &page=#{n}
			puts url
			member_data =  Net::HTTP.get(URI.parse(url))
			doc = Nokogiri::HTML(member_data)
			doc.xpath("//user/id").map(&:text) 
		end	
end