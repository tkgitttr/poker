Rails.application.routes.draw do
  root 'cards#index'
  get  'cards/index'
  post "/" => "cards#index"
  resources :cards #これがあるとindexがupdateとみなされることがある

  # grape APIのルーティング
  # mount API::Root => '/api'
  mount API::Root => '/' #prefixつけた場合は"/"のみの記述

  # serviceを導入するのにrouting必要?#####
    #   resources :card_form_service do
    #     collection do
    #       get 'card_form_service' => "card_form_service#index"
    #       post 'index' => "card_form_service#index"
    #     end
    #   end
    #   resources :cardformservice do
    #     collection do
    #       get 'cardformservice' => "cardformservice#index"
    #       post 'index' => "cardformservice#index"
    #     end
    #   end
    #   resources :hoge
    #   # match 'hoges' => 'hoge#hoges'
    #   get '/cards/hoges', to: 'hoge#hoges'
    #   resources :hoge do
    #     member do
    #       get 'hoges'
    #       post "/hoges" => "hoge#hoges"
    #     end
    #   end
    # get ':hoge/hoges'
    resources :cards do #/cards にアクセスしたとき
      collection do
        get :hoge #getで cards/hoge に対してhogeアクションを追加
      end
    end
  ##########################################
end

