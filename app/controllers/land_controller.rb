class LandController < ApplicationController
  def publications
  	
    @fox_articles = Article.where(:publication => "fox news")
  	@fox_scrape_sessions = []
  	@fox_articles.each{|arti|
  		@fox_scrape_sessions << arti.scrape_session
  	}
  	@fox_scrape_sessions.uniq!

    @nyt_articles = Article.where(:publication => "new york times")
    @nyt_scrape_sessions = []
    @nyt_articles.each{|arti|
      @nyt_scrape_sessions << arti.scrape_session
    }
    @nyt_scrape_sessions.uniq!

  end
end
