starttime = Time.now

ENV['TZ'] = 'America/New_York'





def scrape(page,xpath)
	begin
	  request = RestClient::Resource.new(page, :verify_ssl => false).get
	rescue RestClient::NotFound => not_found
	  return not_found
	rescue 
	  return nil
	else
	  	payload = []
	  	Nokogiri::HTML(request).xpath(xpath).map{|item|
			payload << item.text.strip if item != nil
		}
		return payload
	end
end





scheduler = Rufus::Scheduler.new

#scheduler.every '3h' do
scheduler.cron '*/20 * * * *', :first_at => Time.now + 60 do 

	# Set ScrapeSession
	scrape_sesh = Time.now

	# Get all links from main homepage content container
	results = scrape("https://www.nytimes.com/","//section[@id='top-news']//a/@href").uniq!

	## FILTER RESULTS ##
	
	
	refined = []
	results.each{|r|
		if r.include?("?")
			# clean up url tracking 
			qmarkindex = r.index("?")
			refined << r[0..(qmarkindex-1)] if r.start_with?("https://www.nytimes.com/") or r.start_with?("http://www.nytimes.com/")
		else
			# take only articles from nytimes.com
			refined << r if r.start_with?("https://www.nytimes.com/") or r.start_with?("http://www.nytimes.com/")
		end
	}

	refined.uniq!
	# exclude video content
	refined.reject!{|u| u.include?("/video/")}
	#exclude newsletter content
	refined.reject!{|u| u.include?("/newsletters/")}
	#exclude interactive content
	refined.reject!{|u| u.include?("/interactive/")}
	#exclude times landing pages
	refined.reject!{|u| u.length < 50 }

	articles = []
	refined.each{|url|
		@hsh = {}
		@hsh[:scrape_session] = scrape_sesh
		@hsh[:publication] = "new york times"
		@hsh[:url] = url
		@hsh[:body] = scrape(url,"//article[@id='story']//p").join(" ")

		articles << @hsh
	}


	count = 0
	articles.uniq.each{|a|
		next if Article.where(:url => a[:url]).count > 0
		Article.create!(a)
		count += 1
	}


	puts "\n~~~\ncreated #{count} new york times articles in #{Time.now-starttime} seconds\n~~~\n"


end # END SCHEDULER

