module API
  module Ver1
    class Cards < Grape::API
      format :json
      formatter :json, Grape::Formatter::Jbuilder

      # /api/ver1/cards/
      # sessionとかではなく，どうやって@cardに代入する？
      # get '/cards' do
        # @cards = { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H1" ] }
        # @cards.save
      # end

      # データベースに保存できるかの確認
      # has_many :hoge
      # get '/cards' do
      #   @hoge = Hoge.new(name: "foo", text: "bar")
      #   @hoge.save
      #   puts @hoge
      # end

      resource :cards do
        # GET /api/ver1/cards
        desc 'Return all cards.'
        get '/', jbulder: 'card' do  #card.jbulderをviewとして使う
          Card.all
        end
      end

      # 接続テスト #表示されない
      # get '/cards' do
      #   puts "cards success!"
      # end

      post '/cards' do
        @cards = { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7" ] }
      end

    end
  end
end