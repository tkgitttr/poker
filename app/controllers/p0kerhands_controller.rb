class P0kerhandsController < ApplicationController
  def home

    # 変数受け取り，設定
    card_params = params[:cards]
    if card_params.nil?
      @cards = ['S1','H2', 'D3', 'C4', 'S5'] #後ほど変更する必要あり
    else
      @cards = card_params.split
    end
    @suits = @cards.map { |c| c[0] }
    @nums  = @cards.map { |c| c[1].to_i }

    # カードの役を判定する
    if @suits.uniq.length == 1 && @nums.uniq.length == 5 && @nums.max - @nums.min == 4
      @result = 'ストレートフラッシュ'
    elsif @nums.count(@nums.max_by { |v| @nums.count(v) }) == 4
      @result = 'フォー・オブ・ア・カインド'
    elsif @nums.uniq.count == 2
      @result = 'フルハウス'
    elsif @suits.uniq.length == 1
      @result = 'フラッシュ'
    elsif @nums.uniq.length == 5 && @nums.max-@nums.min == 4
      @result = 'ストレート'
    elsif @nums.count(@nums.max_by { |v| @nums.count(v) }) == 3
      @result = 'スリー・オブ・ア・カインド'
    elsif @nums.uniq.length == 3
      @result = 'ツーペア'
    elsif @nums.uniq.length == 4
      @result = 'ワンペア'
    else
      @result = 'ハイカード'
    end
  end

end