json.result @cards do |card|
  # json.(card, :first_card, :second_card)
  json.(card)
end

json.cards @cards #入力をそのまま出力