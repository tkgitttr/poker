class CardsController < ApplicationController

  def index
    # session.clear #debug
    if session[:all_card].nil?
      @card = Card.new(all_card: "")
    else
      @card = Card.new(all_card: session[:all_card])
      @result = session[:result]
      @errors = session[:card_errors]
    end
  end

  def create
    service = CardFormService.new(card_params[:all_card]) if card_params
    if service.save
      session[:result] = service.hand
      session[:card_errors] = nil
    else
      # session[:result] = ""
      session[:card_errors] = service.error_msg
    end
    session[:all_card] = service.card
    redirect_to root_path
  end

  private
    def card_params
      params.require(:card).permit(:all_card)
    end
end