class Card < ApplicationRecord

  validate :card_format

  def card_format
    CardFormService.valid(all_card,first_card,second_card,third_card,fourth_card,fifth_card,errors)
  end

end
