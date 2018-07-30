Rails.application.routes.draw do
  root 'cards#index'
  get  'cards/index'
  post "/" => "cards#index"
  resources :cards #これがあるとindexがupdateとみなされることがある

  # grape APIのルーティング
  mount API::Root => '/' #prefixつけた場合は"/"のみの記述

end

