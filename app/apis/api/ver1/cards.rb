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
            @result.compact!
            @errors.compact! #nilを消す
          end

          # @resultのカードは，役を判定する
          @result.each_with_index do |r,ind|
            @suits, @nums = CardFormService.separate_suit_num(r[:card])
            r[:hand], @rank[ind] = CardFormService.judge_hand(@suits, @nums)
          end

          #bestかどうかを判定する
          indexes = @rank.each_with_index.map{ |v,i| v == @rank.max ? i : nil }.compact
          @result.each_with_index{ |r,ind| r[:best] = indexes.include?(ind) ? true : false }
        end
      end
    end
  end
end