class P0kerhandsController < ApplicationController
  def home
    @hands = Hand.new
  end
end
