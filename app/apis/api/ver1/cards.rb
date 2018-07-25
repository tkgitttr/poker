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
          @results = []
          @errors = []
          rank   = []
          cards_params[:cards].each_with_index do |c, ind|
            service = CardFormService.new(c)
            card = Card.new({all_card: service.card, first_card: service.first_card, second_card: service.second_card, third_card: service.third_card, fourth_card: service.fourth_card, fifth_card: service.fifth_card })
            if card.save
              #resultのメソッド...handを判定してcardとhandを入れる
              @results[ind] = { card: c }
              @results[ind][:hand] = service.hand
              rank[ind] = service.rank
            else
              #errorsのメソッド...cardとエラーメッセージを入れる
              @errors[ind] = {card: c}
              @errors[ind][:msg] = card.errors.full_messages #配列になって，かつエスケープされてしまう
            end
          end
          @results.compact!
          @errors.compact!
          rank.compact!
          #bestかどうかの判定
          indexes = rank.each_with_index.map{ |v,i| v == rank.max ? i : nil }.compact
          @results.each_with_index{ |r,ind| r[:best] = indexes.include?(ind) ? true : false }
        end
      end
    end
  end
end