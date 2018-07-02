Rails.application.routes.draw do
  root 'cards#index'
  get  'cards/index'
  post "/" => "cards#index"
  resources :cards #これがあるとindexがupdateとみなされることがある


  # grape APIのルーティング
  # 下の2行は，原因不明で使えない
  # mount API::Root => '/api'
  mount API::Root => '/' #prefixつけた場合は"/"のみの記述

  # mount API::Ver1::Root => '/'
  # mount Api::Ver1::Root => '/'
  # mount API => '/api'
  # mount API::API => '/api'
  # mount API::Root

  # API用(GrapeではなくRailsでAPI?)
  # namespace :api, {format: 'json'} do
  #   namespace :v1 do
  #     namespace :cards do
  #       get "/" , :action => "index"
  #       post "/", :action => "index"
  #     end
  #   end
  # end

end

