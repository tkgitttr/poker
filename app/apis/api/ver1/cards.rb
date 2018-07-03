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
        # desc 'Return all cards.'
        # get '/', jbuilder: 'ver1/index' do  #index.jbulderをviewとして使う
        #   @cards = Card.all
        # end

        post '/check', jbuilder: 'ver1/index' do

          @result = []
          @hand = []
          @rank = []
          @errors = []
          cards_params[:cards].each_with_index do |card,ind|
            # modelバリデーションを呼び出したい
            @card = Card.new(all_card: card)
            @card[:all_card].split(" ").each_with_index do |c,ind|
              @card[:first_card]  = c if ind == 0
              @card[:second_card] = c if ind == 1
              @card[:third_card]  = c if ind == 2
              @card[:fourth_card] = c if ind == 3
              @card[:fifth_card]  = c if ind == 4
            end
            @card.save
            if @card.save
              @result[ind] = { card: card }
            else
              @errors[ind] = { card: card }
              @errors[ind][:msg] = @card.errors.full_messages #エラーメッセージの取得方法?
            end
          end

          # ここに，handを判定するロジックと,bestを判定するロジックを書く
          cards_params[:cards].each_with_index do |card,ind|

            # カードをスートと数字に分解する
            @suits = card.split(" ").map{ |c| c[0] }
            @nums = card.split(" ").map{ |c| c[1..-1].to_i }

            # カードの役を判定する
            # ストレートフラッシュの判定，13，１，２，，，のような飛びに対応していないので修正
            if (@suits.uniq.length == 1 && @nums.uniq.length == 5) &&
                (@nums.max - @nums.min == 4 || (@nums.min == 1 && @nums.sum == 47))
              @hand[ind] = 'ストレートフラッシュ'
              @rank[ind] = 9
            elsif @nums.count(@nums.max_by { |v| @nums.count(v) }) == 4
              @hand[ind] = 'フォー・オブ・ア・カインド'
              @rank[ind] = 8
            elsif @nums.uniq.count == 2
              @hand[ind] = 'フルハウス'
              @rank[ind] = 7
            elsif @suits.uniq.length == 1
              @hand[ind] = 'フラッシュ'
              @rank[ind] = 6
            elsif @nums.uniq.length == 5 &&
                (@nums.max - @nums.min == 4 || (@nums.min == 1 && @nums.sum == 47))
              @hand[ind] = 'ストレート'
              @rank[ind] = 5
            elsif @nums.count(@nums.max_by { |v| @nums.count(v) }) == 3
              @hand[ind] = 'スリー・オブ・ア・カインド'
              @rank[ind] = 4
            elsif @nums.uniq.length == 3
              @hand[ind] = 'ツーペア'
              @rank[ind] = 3
            elsif @nums.uniq.length == 4
              @hand[ind] = 'ワンペア'
              @rank[ind] = 2
            else
              @hand[ind] = 'ハイカード'
              @rank[ind] = 1
            end
          end

          cards_params[:cards].each_with_index do |card,ind|
            # いい方法が見つからないが，とりあえずエラー回避しつつ:handを代入
            if @result[ind] && @result[ind].has_key?(:card)

              @result[ind][:hand] = @hand[ind]

              if @rank[ind] == @rank.max
                @result[ind][:best] = true
              else
                @result[ind][:best] = false
              end
            end
          end


          # @card = {}
          # @hand = {}
          # @best = {}

          # @cards = cards_params[:cards]
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