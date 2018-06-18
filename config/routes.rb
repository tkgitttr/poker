Rails.application.routes.draw do
  root 'cards#index'
  get  'cards/index'
  post "/" => "cards#index"
  resources :cards
end
