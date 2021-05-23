Rails.application.routes.draw do
  devise_for :users
  resources :tags
  resources :categories
  root "articles#index"

  resources :articles do
    resources :comments
  end

  match 'tagged' => 'articles#tagged', :as => 'tagged', :via => :get

  get '/search' => 'articles#search', :as => 'search_article'
end
