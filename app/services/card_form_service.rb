class CardFormService < ApplicationRecord

  attr_reader :card, :first_card, :second_card, :third_card, :fourth_card, :fifth_card, :hand, :rank, :error_msg

  def initialize(all_card)
    @card = all_card
    get_five_cards
    separate_suit_num
    judge_hand
  end

  def save
    if valid?
      card_set = Card.new({all_card: @card, first_card: @first_card, second_card: @second_card, third_card: @third_card, fourth_card: @fourth_card, fifth_card: @fifth_card })
      card_set.save
      true
    else
      false
    end
  end

  private

    def get_five_cards
      @card.split(" ").each_with_index do |c,ind|
        @first_card = c if ind == 0
        @second_card = c if ind == 1
        @third_card = c if ind == 2
        @fourth_card = c if ind == 3
        @fifth_card = c if ind == 4
      end
    end

    def separate_suit_num
      @suits = @card.split(" ").map{ |c| c[0] }
      @nums = @card.split(" ").map{ |c| c[1..-1].to_i }
    end

    VALID_CARD_REGEX = /[CDHS]([1-9]|1[0-3])\z/ #CDHSのいずれか+1~13までの数字
    # validate :valid?
    def valid?
      #errorを引数で渡す必要があるのか
      if card_num_valid?
        # @error_msgを配列にする必要あり
        @error_msg =[]
        @error_msg << "1番目のカード指定文字が不正です。 (#{@first_card})"  if @first_card  !~ VALID_CARD_REGEX
        @error_msg << "2番目のカード指定文字が不正です。 (#{@second_card})" if @second_card !~ VALID_CARD_REGEX
        @error_msg << "3番目のカード指定文字が不正です。 (#{@third_card})"  if @third_card  !~ VALID_CARD_REGEX
        @error_msg << "4番目のカード指定文字が不正です。 (#{@fourth_card})" if @fourth_card !~ VALID_CARD_REGEX
        @error_msg << "5番目のカード指定文字が不正です。 (#{@fifth_card})"  if @fifth_card  !~ VALID_CARD_REGEX

        # card = Card.new()
        # card.errors.add("", @errors_msg)
        # errors.add("", @error_msg)

        # if errors.any?
        if !@error_msg.empty?
          @error_msg << "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
          false
        else
          card_unique_valid?
        end
      end
    end

    def card_num_valid?
      if @card.split(" ").length != 5
        @error_msg ||= []
        @error_msg << '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）'
        # errors.add("", @error_msg)
        false
      else
        true
      end
    end

    def card_unique_valid?
      if @card.split(" ").uniq.length < 5
        @error_msg ||= []
        @error_msg << "カードが重複しています。"
        false
      else
        true #明示しないとTrueで返らない
      end
    end

    def judge_hand
      if (@suits.uniq.length == 1 && @nums.uniq.length == 5) &&
          (@nums.max - @nums.min == 4 || (@nums.min == 1 && @nums.sum == 47))
        @hand = 'ストレートフラッシュ'
        @rank = 9
      elsif @nums.count(@nums.max_by { |v| @nums.count(v) }) == 4
        @hand = 'フォー・オブ・ア・カインド'
        @rank = 8
      elsif @nums.uniq.count == 2
        @hand = 'フルハウス'
        @rank = 7
      elsif @suits.uniq.length == 1
        @hand = 'フラッシュ'
        @rank = 6
      elsif @nums.uniq.length == 5 &&
          (@nums.max - @nums.min == 4 || (@nums.min == 1 && @nums.sum == 47))
        @hand = 'ストレート'
        @rank = 5
      elsif @nums.count(@nums.max_by { |v| @nums.count(v) }) == 3
        @hand = 'スリー・オブ・ア・カインド'
        @rank = 4
      elsif @nums.uniq.length == 3
        @hand = 'ツーペア'
        @rank = 3
      elsif @nums.uniq.length == 4
        @hand = 'ワンペア'
        @rank = 2
      else
        @hand = 'ハイカード'
        @rank = 1
      end
    end
end
