module API
  module V1
    class Cards < Grape::API
      format :json

      # /api/ver1/cards/
      # sessionとかではなく，どうやって@cardに代入する？
      # get '/cards' do
      #   @cards = { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7" ] }
      # end

      # resource :cards do
      #   # GET /api/ver1/cards
      #   desc 'Return all cards.'
      #   get do
      #     Card.all
      #   end

      # 接続テスト
      get '/cards' do
        puts "cards success!"
      end

      # post '/cards' do
      #   @cards = { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7" ] }
      # end

    end
  end
end