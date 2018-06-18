class CardsController < ApplicationController

  def index

    # 変数受け取り，設定
    @card = Card.new # いらないみたい？
    # session
    # session.clear #debag
    if session[:all_card].nil?
      @card[:all_card] = "S1 S2 S3 S4 S5"
    else
      @card[:all_card] = session[:all_card]
    end
    @result = session[:result]
    # card_params = params[:card][:all_card] #ここは変更しないといけない
    # @card = Card.new({all_card: 'S1 A2 D5 C13 A4'}) #後ほど変更する必要あり
    # if card_params
    #   @card[:all_card] = card_params
    # end
    # # カードを1～5枚目に分解する
    # @card[:all_card].split(" ").each_with_index do |c,ind|
    #   @card[:first_card]  = c if ind == 0
    #   @card[:second_card] = c if ind == 1
    #   @card[:third_card]  = c if ind == 2
    #   @card[:fourth_card] = c if ind == 3
    #   @card[:fifth_card]  = c if ind == 4
    # end
    # # カードをスートと数字に分解する(valuesがなぜか使えない)
    # @suits = [@card[:first_card][0], @card[:second_card][0],@card[:third_card][0],@card[:fourth_card][0],@card[:fifth_card][0]]
    # @nums = [@card[:first_card][1].to_i,@card[:second_card][1].to_i,@card[:third_card][1].to_i,@card[:fourth_card][1].to_i,@card[:fifth_card][1].to_i]
    # # @suits = @card.to_a.map { |c| c[0] } #消す
    # # @nums  = @card.to_a.map { |c| c[1].to_i }
    #
    # # カードの役を判定する
    # if @suits.uniq.length == 1 && @nums.uniq.length == 5 && @nums.max - @nums.min == 4
    #   @result = 'ストレートフラッシュ'
    # elsif @nums.count(@nums.max_by { |v| @nums.count(v) }) == 4
    #   @result = 'フォー・オブ・ア・カインド'
    # elsif @nums.uniq.count == 2
    #   @result = 'フルハウス'
    # elsif @suits.uniq.length == 1
    #   @result = 'フラッシュ'
    # elsif @nums.uniq.length == 5 && @nums.max-@nums.min == 4
    #   @result = 'ストレート'
    # elsif @nums.count(@nums.max_by { |v| @nums.count(v) }) == 3
    #   @result = 'スリー・オブ・ア・カインド'
    # elsif @nums.uniq.length == 3
    #   @result = 'ツーペア'
    # elsif @nums.uniq.length == 4
    #   @result = 'ワンペア'
    # else
    #   @result = 'ハイカード'
    # end
  end

  def create #いる？

    # @card = params[:all_card]
    # @card.save #いる？

    # 変数受け取り，設定
    # @card = Card.new # いらないみたい？
    # card_params = params[:card] #ここは変更しないといけない
    @card = Card.new #({all_card: 'S1 A2 D5 C13 A4'})#後ほど変更する必要あり
      if card_params
        @card[:all_card] = card_params[:all_card]
      end
    # sessionに保存
    # session = {} #前回のセッションを切る？
    session[:all_card] = @card[:all_card]
    # error
    # カードを1～5枚目に分解する
    @card[:all_card].split(" ").each_with_index do |c,ind|
      @card[:first_card]  = c if ind == 0
      @card[:second_card] = c if ind == 1
      @card[:third_card]  = c if ind == 2
      @card[:fourth_card] = c if ind == 3
      @card[:fifth_card]  = c if ind == 4
    end
    # カードをスートと数字に分解する(valuesがなぜか使えない)
    @suits = [@card[:first_card][0], @card[:second_card][0],@card[:third_card][0],@card[:fourth_card][0],@card[:fifth_card][0]]
    @nums = [@card[:first_card][1].to_i,@card[:second_card][1].to_i,@card[:third_card][1].to_i,@card[:fourth_card][1].to_i,@card[:fifth_card][1].to_i]
    # @suits = @card.to_a.map { |c| c[0] } #消す
    # @nums  = @card.to_a.map { |c| c[1].to_i }

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

    #result をセッションに保存
    session[:result] = @result
    # render cards_index_url
    redirect_to root_path#(card: :all_card )
  end

  private
    def card_params
      params.require(:card).permit(:all_card)
    end
end