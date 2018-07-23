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
          @rank   = []
          # @service = []

          #カードを，@resultと@errorsに振り分ける
          @result, @errors = CardFormService.distribute_result_errors(cards_params)

          # @resultは分解し，役を判定する
          @result.each_with_index do |r,ind|
            service = CardFormService.new(r)
            # @suits, @nums = CardFormService.separate_suit_num(r[:card])
            # r[:hand], @rank[ind] = CardFormService.judge_hand(@suits, @nums)
            service.get_result
            @rank[ind] = service.rank
          end

          # @resultは，bestかどうかを判定する
          # indexes = @rank.each_with_index.map{ |v,i| v == @rank.max ? i : nil }.compact
          indexes = @rank.each_with_index.map{ |v,i| v == @rank.max ? i : nil }.compact
          @result.each_with_index{ |r,ind| r[:best] = indexes.include?(ind) ? true : false }
        end
      end
    end
  end
end