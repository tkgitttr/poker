class Card < ApplicationRecord

  VALID_CARD_REGEX = /[CDHS]([1-9]|1[0-3])\z/ #CDHSのいずれか+1~13までの数字
  validate :card_format

  def card_format
    if all_card.split(" ").length == 5
      errors.add(" ", "1番目のカード指定文字が不正です。 (#{first_card})")  if first_card  !~ VALID_CARD_REGEX
      errors.add(" ", "2番目のカード指定文字が不正です。 (#{second_card})") if second_card !~ VALID_CARD_REGEX
      errors.add(" ", "3番目のカード指定文字が不正です。 (#{third_card})")  if third_card  !~ VALID_CARD_REGEX
      errors.add(" ", "4番目のカード指定文字が不正です。 (#{fourth_card})") if fourth_card !~ VALID_CARD_REGEX
      errors.add(" ", "5番目のカード指定文字が不正です。 (#{fifth_card})")  if fifth_card  !~ VALID_CARD_REGEX
      if first_card !~ VALID_CARD_REGEX || second_card !~ VALID_CARD_REGEX || third_card !~ VALID_CARD_REGEX ||
          fourth_card !~ VALID_CARD_REGEX || fifth_card !~ VALID_CARD_REGEX
        errors.add(" ", "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。")
      end
      if all_card.split(" ").uniq.length < 5
        errors.add(" ", "カードが重複しています。")
      end
    else
      errors.add(" ",'5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）')
    end
  end

end
