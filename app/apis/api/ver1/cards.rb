module API
  module Ver1
    class Cards < Grape::API
      format :json
      formatter :json, Grape::Formatter::Jbuilder

      helpers do
        #Strong Parametersの設定
        def cards_params
          ActionController::Parameters.new(params).permit(cards: [])
        end
      end

      resource :cards do
        # GET /api/ver1/cards
        desc 'Return all cards.'
        get '/', jbuilder: 'ver1/index' do  #index.jbulderをviewとして使う
          @cards = Card.all
        end

        post '/check', jbuilder: 'ver1/index' do

          @result = []
          cards_params[:cards].each_with_index do |card,ind|
            @result[ind] = {card: card, hand: "ストレートフラッシュ", best: false }
            # この記法はうまくいかない（消して良い)
            # @card[ind] = card
            # @hand[ind] = "ストレートフラッシュ"
            # @best[ind] = false
          end
          # @card = {}
          # @hand = {}
          # @best = {}

          @cards = cards_params[:cards]
          # @cards = { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7" ,"post"] }
          # cards_params[:cards].map do |cards|
          #   @card = Card.new(all_card: cards)
          # end
          # @cards = [ Card.first, Card.second]
          # first_card = cards_params[:first_card]
          # @cards[0].first_card = first_card #paramから受けとったものを反映
          # @cards.save #不要.
        end
      end

      # /api/ver1/cards/
      # sessionとかではなく，どうやって@cardに代入する？
      # get '/cards' do
      # @cards = { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H1" ] }
      # @cards.save
      # end

      # データベースに保存できるかの確認
      # has_many :hoge
      # get '/cards' do
      #   @hoge = Hoge.new#(name: "foo", text: "bar")
      #   # @hoge.save
      #   puts @hoge #これはできない.JSON形式だから？
      # end

      # 接続テスト #表示されない
      # get '/cards' do
      #   puts "cards success!"
      # end

    end
  end
end