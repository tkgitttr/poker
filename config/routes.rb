Rails.application.routes.draw do
  root 'cards#index'
  get  'cards/index'
  post "/" => "cards#index"
  resources :cards #これがあるとindexがupdateとみなされることがある


  # grape APIのルーティング
  # mount API::Root => '/api'
  # mount API::Root => '/' #prefixつけた場合は"/"のみの記述？

  # API用
  namespace :api, {format: 'json'} do
    namespace :v1 do
      namespace :cards do
        get "/" , :action => "index"
        # post "/", :action => "index"
      end
    end
  end

end

