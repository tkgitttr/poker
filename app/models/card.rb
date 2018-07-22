class Card < ApplicationRecord

  validate :card_format#, :valid?

  def card_format
    # service = CardFormService.new(all_card)
    # service.get_five_cards
    CardFormService.valid(all_card,first_card,second_card,third_card,fourth_card,fifth_card,errors)
    # service.valid(all_card,first_card,second_card,third_card,fourth_card,fifth_card,errors)
    # return false unless service.valid?
    # unless service.valid?
      # errors
    # end
    # raise
  end

end
