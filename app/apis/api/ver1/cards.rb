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

        post '/check', jbuilder: 'ver1/index' do

          @result = []
          @rank   = []
          @errors = []

          #カードを，@resultと@errorsに振り分ける
          cards_params[:cards].each_with_index do |card,ind|
            # modelバリデーションを呼び出す
            @card = Card.new(all_card: card)
            CardFormService.get_five_cards(@card)
            if @card.save
              @result[ind] = { card: card }
            else
              @errors[ind] = { card: card }
              @errors[ind][:msg] = @card.errors.full_messages
            end
            @errors.compact! #nilを消す
          end

          # @resultのカードは，役を判定する
          cards_params[:cards].each_with_index do |card,ind|
            @rank[ind] = 0 #nil回避
            if @result[ind] && @result[ind].has_key?(:card)
              @suits, @nums = CardFormService.separate_suit_num(card)
              @result[ind][:hand], @rank[ind] = CardFormService.judge_hand(@suits, @nums)
              @result[ind][:best] = false
            end
          end
          #bestかどうかを判定する
          indexes = @rank.each_with_index.map{ |v,i| v == @rank.max ? i : nil }.compact
          indexes.each do |i|
            @result[i][:best] = true #これだと複数trueができない
          end
          @result.compact! #出力の都合上, nilを消す必要あり
        end
      end
    end
  end
end