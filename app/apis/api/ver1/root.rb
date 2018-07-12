module API
  module Ver1
    class Root < Grape::API
      # これでdomain/api/v1でアクセス出来るようになる。
      version 'v1', using: :path #/v1がパスにつく #using: :pathを入れるとどうなる？
      format :json

      mount API::Ver1::Cards
    end
  end
end