json.extract! scrape_session, :id, :scrape_date, :scrape_time, :created_at, :updated_at
json.url scrape_session_url(scrape_session, format: :json)
