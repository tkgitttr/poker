class CardFormService < ApplicationRecord
# class Cards < ApplicationRecord
# class Card < ApplicationRecord
#モデルバリデーションを使えるように #クラス名はmodelと同じ？Cards?

  # def initialize(all_card)
  #   @card = {all_card: all_card } #これでいける？
  # end

  def self.initialize
  end

  def foo(foo)
    foo
  end
  def self.hoge(foo)
    foo
  end
  def index

  end

  # def self.servicehoge
  #   "Servicehoge"
  # end
  # def CardFormService.servicehoge
  # end
  # def Cards.servicehoge
  # end
  # def Card.servicehoge
  # end


  # private
  #   attr_reader :all_card
  #
  #   def valid
  #     if all_card.split(" ").length == 5
  #       errors.add(" ", "1番目のカード指定文字が不正です。 (#{first_card})")  if first_card  !~ VALID_CARD_REGEX
  #       errors.add(" ", "2番目のカード指定文字が不正です。 (#{second_card})") if second_card !~ VALID_CARD_REGEX
  #       errors.add(" ", "3番目のカード指定文字が不正です。 (#{third_card})")  if third_card  !~ VALID_CARD_REGEX
  #       errors.add(" ", "4番目のカード指定文字が不正です。 (#{fourth_card})") if fourth_card !~ VALID_CARD_REGEX
  #       errors.add(" ", "5番目のカード指定文字が不正です。 (#{fifth_card})")  if fifth_card  !~ VALID_CARD_REGEX
  #       if first_card !~ VALID_CARD_REGEX || second_card !~ VALID_CARD_REGEX || third_card !~ VALID_CARD_REGEX ||
  #           fourth_card !~ VALID_CARD_REGEX || fifth_card !~ VALID_CARD_REGEX
  #         errors.add(" ", "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。")
  #       end
  #       if all_card.split(" ").uniq.length < 5
  #         errors.add(" ", "カードが重複しています。")
  #       end
  #     else
  #       errors.add(" ",'5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）')
  #     end
  #   end
  #
  #   def self.judge(suits, nums)
  #     @suits = suits
  #     @nums = nums
  #     @result = []
  #     # カードの役を判定する
  #     if (@suits.uniq.length == 1 && @nums.uniq.length == 5) &&
  #         (@nums.max - @nums.min == 4 || (@nums.min == 1 && @nums.sum == 47))
  #       @result = 'ストレートフラッシュ'
  #     elsif @nums.count(@nums.max_by { |v| @nums.count(v) }) == 4
  #       @result = 'フォー・オブ・ア・カインド'
  #     elsif @nums.uniq.count == 2
  #       @result = 'フルハウス'
  #     elsif @suits.uniq.length == 1
  #       @result = 'フラッシュ'
  #     elsif @nums.uniq.length == 5 &&
  #         (@nums.max - @nums.min == 4 || (@nums.min == 1 && @nums.sum == 47))
  #       @result = 'ストレート'
  #     elsif @nums.count(@nums.max_by { |v| @nums.count(v) }) == 3
  #       @result = 'スリー・オブ・ア・カインド'
  #     elsif @nums.uniq.length == 3
  #       @result = 'ツーペア'
  #     elsif @nums.uniq.length == 4
  #       @result = 'ワンペア'
  #     else
  #       @result = 'ハイカード'
  #     end
  #
  #   end
end
