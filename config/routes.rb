Rails.application.routes.draw do
  get 'land/publications'
  root 'land#publications'
  resources :articles
  resources :scrape_sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
