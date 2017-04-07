json.extract! article, :id, :scrape_session, :publication, :url, :body, :pub_date, :created_at, :updated_at
json.url article_url(article, format: :json)
