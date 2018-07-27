class Card < ApplicationRecord

  validate :card_format

  # def self.raise_validation_error
  #   raise ActiveRecord::RecordInvalid.new(self.new)
  # end

  def card_format
    # CardFormService.valid(all_card,first_card,second_card,third_card,fourth_card,fifth_card,errors)
    #service層のクラスメソッドからインスタンスメソッドに移行
    # service = CardFormService.new(all_card)
    # service.valid?
    # if service.save
    #   true
    # else
    #   false
    # end
    # unless service.valid?
    #   # Card.raise_validation_error
    #   errors.add(" ",service.error_msg)
    # end
  end

  # saveメソッド定義する必要あり？調べる

end
