module API
  module Ver1
    class Cards < Grape::API
      format :json
      formatter :json, Grape::Formatter::Jbuilder

      helpers do
        def cards_params
          ActionController::Parameters.new(params).permit(cards: [])
        end
      end

      resource :cards do
        post '/check', jbuilder: 'ver1/index' do
          #初期化
          @results = []
          @errors = []
          rank   = []

          #役判定，保存
          cards_params[:cards].each_with_index do |c, ind|
            service = CardFormService.new(c)
            if service.save
              @results[ind] = { card: c }
              @results[ind][:hand] = service.hand
              rank[ind] = service.rank
            else
              @errors[ind] = {card: c}
              @errors[ind][:msg] = service.error_msg
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