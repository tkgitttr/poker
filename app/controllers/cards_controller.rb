class CardsController < ApplicationController

  def index
    # session.clear #debug
    if session[:all_card].nil?
      @card = Card.new(all_card: "")
    else
      @card = CardFormService.set_card_from_session(session)
      @result = session[:result] if @card.save
    end
  end

  def create
    @card = Card.new
    @card[:all_card] = card_params[:all_card] if card_params
    CardFormService.get_result(@card,session)
    redirect_to root_path
  end

  private
    def card_params
      params.require(:card).permit(:all_card)
    end
end