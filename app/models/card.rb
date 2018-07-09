class Card < ApplicationRecord

  VALID_CARD_REGEX = /[CDHS]([1-9]|1[0-3])\z/ #CDHSのいずれか+1~13までの数字
  validate :card_format

  def card_format
    CardFormService.valid(all_card,first_card,second_card,third_card,fourth_card,fifth_card,VALID_CARD_REGEX,errors)
  end

end
