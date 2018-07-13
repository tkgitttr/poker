module API
  module Ver1
    class Root < Grape::API
      # これでdomain/api/v1でアクセス出来るようになる。
      version 'v1', using: :path #/v1がパスにつく #using: :pathを入れるとどうなる？
      format :json

      mount API::Ver1::Cards

      # #######################################
      # rescue_from :all do |e|
      #   my_error!("不正なリクエストです．",e)
      # end
      # rescue_from Grape::Exceptions::ValidationErrors do |e|
      #   my_error!({ messages: e.full_messages }, 400)
      # end
      # #############################

    end
  end
end