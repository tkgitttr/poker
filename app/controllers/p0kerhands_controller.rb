class P0kerhandsController < ApplicationController
  def home
    @cards = params[:hands].split
    @suits = @cards.map { |c| c[0] }
    @nums  = @cards.map { |c| c[1].to_i }

    if @suits.uniq.length == 1 && @nums.max - @nums.min == 4
      @result = 'ストレートフラッシュ'
    elsif @nums.count(@nums.max_by { |v| @nums.count(v) }) == 4
      @result = 'フォー・オブ・ア・カインド'
    elsif @nums.uniq.count == 2
      @result = 'フルハウス'
    elsif @suits.uniq.length == 1
      @result = 'フラッシュ'
    elsif @nums.max-@nums.min == 4
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

  # def create
  #     @cards = Hand.new(params[:hands])
  #     render root_path
  # end

end