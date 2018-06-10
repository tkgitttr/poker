class P0kerhandsController < ApplicationController
  def home
    @hands = params[:hands]
  end

  def create
    @hands = Hand.new(article_params)
      render root_path
  end

end