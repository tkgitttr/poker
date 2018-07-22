class CardsController < ApplicationController
  # service = CardFormService.new(session[:all_card])

  def index
    # service = CardFormService.new()
    # @service = CardFormService.new(session[:all_card])
    # session.clear #debug
    service ||= CardFormService.new()
    if session[:all_card].nil?
      @card = Card.new(all_card: "")
      # raise
    else
      # @card = CardFormService.set_card_from_session(session)
      @card = Card.new(all_card: session[:all_card])
      @result = session[:result]
      @errors = session[:card_errors]
      # raise
      # service = service.get_five_cards
      # @result = session[:result] if @card.save
      # service = CardFormService.new(session[:all_card])
      # service.get_five_cards
      # card_set = Card.new({all_card: service.card, first_card: service.first_card, second_card: service.second_card, third_card: service.third_card, fourth_card: service.fourth_card, fifth_card: service.fifth_card })
      # @result = service.result if card_set.save
    end
  end

  def create
    @card = Card.new
    @card[:all_card] = card_params[:all_card] if card_params
    # CardFormService.get_result(@card,session)
    service = CardFormService.new(card_params[:all_card])
    service.get_five_cards
    card_set = Card.new({all_card: service.card, first_card: service.first_card, second_card: service.second_card, third_card: service.third_card, fourth_card: service.fourth_card, fifth_card: service.fifth_card })
    #
    # バリデーションこっちで呼び出しちゃう？@errorsを保持したい
    # service.valid?
    if card_set.save #カードの保存に成功したとき
      result, rank = service.get_result
      session[:card_errors] = nil
    else #失敗したとき．エラーを返す
      service.valid?
      # result = service.error_msg
      # result = Card.errors.full_massage
      # result = errors.full_massage
      # session[:card_errors] = @card.errors.full_messages
      session[:card_errors] = card_set.errors.full_messages
    end
    #indexに渡すためにsessionに保存
    session[:result] = result
    session[:all_card] = service.card
    # session[:errors] = service.error_msg
    # @result = service.result if card_set.save
    redirect_to root_path
  end

  private
    def card_params
      params.require(:card).permit(:all_card)
    end
end