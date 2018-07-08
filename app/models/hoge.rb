class Hoge < ApplicationRecord
 #呼び出しが来るまではシンタックスエラーも起きない
  # raise(error)
  def self.hoges
    render text: "hoges"
    "Hoges!!!!!!"
  end

  def index

  end
  def show

  end
  def Hoge.hogehoge
    # redirect_to root_path
  end
end