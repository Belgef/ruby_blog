Rails.application.routes.draw do
  resources :categories
  root "articles#index"

  resources :articles do
    resources :comments
  end
end
