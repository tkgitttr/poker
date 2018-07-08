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
          @hand   = []
          @rank   = []
          @errors = []
          cards_params[:cards].each_with_index do |card,ind|
            # modelバリデーションを呼び出す
            @card = Card.new(all_card: card)
            CardFormService.get_five_cards(@card)
            @card.save
            if @card.save
              @result[ind] = { card: card }
            else
              @errors[ind] = { card: card }
              @errors[ind][:msg] = @card.errors.full_messages
            end
            @errors.compact! #nilを消す
          end

          cards_params[:cards].each_with_index do |card,ind|
            # カードをスートと数字に分解する
            @suits = card.split(" ").map{ |c| c[0] }
            @nums = card.split(" ").map{ |c| c[1..-1].to_i }

            @hand[ind], @rank[ind] = CardFormService.judge_hand(@suits, @nums)
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
          @result.compact! #出力の都合上, nilを消す必要あり
        end
      end
    end
  end
end