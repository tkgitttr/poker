class Card < ApplicationRecord

  # attr_accessor :all_card
  VALID_CARD_REGEX = /[CDHS]([1-9]|1[0-3])\z/ #CDHSのいずれか+1~13までの数字
  # validates :all_card, presence: true, length: {maximum: 19} #3文字*5+4スペース
  # validates :first_card, presence: true, format: {with: VALID_CARD_REGEX}
  validate :card_format

  def card_format
      errors.add(" ", "1番目のカード指定文字が不正です。 (#{first_card})")  if first_card  !~ VALID_CARD_REGEX
      errors.add(" ", "2番目のカード指定文字が不正です。 (#{second_card})") if second_card !~ VALID_CARD_REGEX
      errors.add(" ", "3番目のカード指定文字が不正です。 (#{third_card})")  if third_card  !~ VALID_CARD_REGEX
      errors.add(" ", "4番目のカード指定文字が不正です。 (#{fourth_card})") if fourth_card !~ VALID_CARD_REGEX
      errors.add(" ", "5番目のカード指定文字が不正です。 (#{fifth_card})")  if fifth_card  !~ VALID_CARD_REGEX
  end
end
