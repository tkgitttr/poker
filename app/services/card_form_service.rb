class CardFormService < ApplicationRecord
  class << self #クラスメソッドを定義していく

    def hoge(foo) #これはテスト用．後で消す．
      foo
    end

  # private #privateにしてわかりやすくするのは一旦あきらめる
    attr_reader :all_card

    def set_card_from_session(session)
      card = Card.new
      card[:all_card]    = session[:all_card]
      card[:first_card]  = session[:first_card]
      card[:second_card] = session[:second_card]
      card[:third_card]  = session[:third_card]
      card[:fourth_card] = session[:fourth_card]
      card[:fifth_card]  = session[:fifth_card]
      card #cardを返す
    end

    def get_five_cards(card)
      card[:all_card].split(" ").each_with_index do |c,ind|
        card[:first_card]  = c if ind == 0
        card[:second_card] = c if ind == 1
        card[:third_card]  = c if ind == 2
        card[:fourth_card] = c if ind == 3
        card[:fifth_card]  = c if ind == 4
      end
    end

    # def separate_suit_num(card_params)
    #   suits = card_params[:all_card].split(" ").map{ |c| c[0] }
    #   nums = card_params[:all_card].split(" ").map{ |c| c[1..-1].to_i }
    #   [suits,nums]
    # end

    def judge_hand(suits, nums)
      if (suits.uniq.length == 1 && nums.uniq.length == 5) &&
          (nums.max - nums.min == 4 || (nums.min == 1 && nums.sum == 47))
        hand = 'ストレートフラッシュ'
        rank = 9
      elsif nums.count(nums.max_by { |v| nums.count(v) }) == 4
        hand = 'フォー・オブ・ア・カインド'
        rank = 8
      elsif nums.uniq.count == 2
        hand = 'フルハウス'
        rank = 7
      elsif suits.uniq.length == 1
        hand = 'フラッシュ'
        rank = 6
      elsif nums.uniq.length == 5 &&
          (nums.max - nums.min == 4 || (nums.min == 1 && nums.sum == 47))
        hand = 'ストレート'
        rank = 5
      elsif nums.count(nums.max_by { |v| nums.count(v) }) == 3
        hand = 'スリー・オブ・ア・カインド'
        rank = 4
      elsif nums.uniq.length == 3
        hand = 'ツーペア'
        rank = 3
      elsif nums.uniq.length == 4
        hand = 'ワンペア'
        rank = 2
      else
        hand = 'ハイカード'
        rank = 1
      end
      [hand,rank]
    end

    def save_session(session, card, result)
      session[:all_card]    = card[:all_card]
      session[:first_card]  = card[:first_card]
      session[:second_card] = card[:second_card]
      session[:third_card]  = card[:third_card]
      session[:fourth_card] = card[:fourth_card]
      session[:fifth_card]  = card[:fifth_card]
      session[:result] = result
    end

    def valid
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
end
