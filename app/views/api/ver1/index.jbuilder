json.set! :result do
  json.array! @result, :card, :hand, :best
end



        # # 以下，消して良い
        # @card.each_with_index do |card, ind|
        #   # このままだと，キーが同じで，上書きされてしまう．
        #   json.array!  do
        #     json.samp card
        #     json.card @card[ind]
        #     json.hand @hand[ind]
        #     json.best @best[ind]
        #   end
        #   json.card @cards do |card|
        #     # json.(card, :first_card, :second_card)
        #     json.(card.split(" "))
        #   end
        #   json.hand "ストレートフラッシュ"
        #   json.best false
        # end
        # json.cards @card #入力をそのまま出力
        # json.cards @cards #入力をそのまま出力
        # json.first_card @cards.first #最初の1セットだけを抽出できるか確認
        # json.first_array @cards.first.split(" ")