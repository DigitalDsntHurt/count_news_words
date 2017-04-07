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
scheduler.cron '00 */3 * * *', :first_at => Time.now + 2 do 

	# Set ScrapeSession
	scrape_sesh = Time.now

	# Get all links from main homepage content container
	results = scrape("http://www.foxnews.com/","//div[@id='doc']/div[@id='col']//a/@href")

	## FILTER RESULTS ##
	# exclude video content
	results.reject!{|r| r.include?("video.foxnews.com") }
	# exclude weather homepage
	results.reject!{|r| r == "http://www.foxnews.com/weather/index.html?intcmp=latestnews" }
	# exclude slideshow content
	results.reject!{|r| r.include?("/slideshow/")}
	# exclude category pages
	results.reject!{|r| r.include?("/category/")}
	# take only articles from foxnews.com (no network, partnership or affiliate links)
	results.select!{|r| r.start_with?("http://www.foxnews.com/") }
	# clean up url tracking 
	results.map!{|r| r.gsub("?intcmp=latestnews","") }

	articles = []
	results.each{|r| 
		@hsh = {}
		@hsh[:scrape_session] = scrape_sesh
		@hsh[:publication] = "fox news"
		@hsh[:url] = r
		article_results = scrape(r,"//div[@class='article-info']//time/@datetime | //div[@class='article-text']/p")
		@hsh[:body] = article_results[1..-1].join
		@hsh[:pub_date] = article_results[0]

		articles << @hsh
	}

	count = 0
	articles.uniq.each{|a|
		next if Article.where(:url => a[:url]).count > 0
		Article.create!(a)
		count += 1
		#puts "\n~~~~~~\n~~~~~~~~~~~~\n"
	}

	puts "\n~~~\ncreated #{count} fox news articles in #{Time.now-starttime} seconds\n~~~\n"

end # END SCHEDULER