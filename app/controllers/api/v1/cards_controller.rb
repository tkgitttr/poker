class Api::V1::CardsController < ApplicationController
  # これは，RailsAPIを使用する場合なので，いらないはず
  # controllers/api自体，完成した後に消す

  #CSRF対策から，indexアクションを除外してアクセス可能にする
  protect_from_forgery :except => [:index]

  def index
    # @cards = { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7" ] }
    # render json: @cards

    # モデルから値を取得するテスト
    # @cards = Card.all
    # render json: @cards
    @hoge = Hoge.all
    render json: @hoge

    # puts "cards controller works!" #これは表示されない
  end
end