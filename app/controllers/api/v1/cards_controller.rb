class Api::V1::CardsController < ApplicationController
  def index
    @cards = { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7" ] }
    render json: @cards
    puts "cards controller works!"
  end
end