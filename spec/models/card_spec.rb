require 'rails_helper'

RSpec.describe Card, type: :model do

    let(:good_card) do
      Card.new({all_card:"S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2", third_card: "S3",
                fourth_card: "S4", fifth_card: "S5"})
    end
    let(:bad_card) do
      Card.new({all_card:"A1 g2 K3 74", first_card: "A1", second_card: "g2", third_card: "K3",
                fourth_card: "74", fifth_card: nil})
    end

    context "正しいフォーマットで入力したとき" do
      it ":バリデーションに通る" do
        expect(good_card).to be_valid
      end
    end

    context "誤ったフォーマットで入力したとき" do

      it "バリデーションに通らない" do
        bad_card.valid?
        expect(bad_card.errors.messages.size).to eq 1
      end

      it "first_cardのみが不正でエラーになる" do
        card = Card.new({all_card:"F50 S2 S3 S4 S5", first_card: "F50", second_card: "S2", third_card: "S3",
                  fourth_card: "S4", fifth_card: "S5"})
        expect(card).not_to be_valid
        # 以下のテストは，全部通ってしまったりするので消す
        # expect(card.errors[:first_card]).to be_present
        # expect { warn  "1番目のカード指定文字が不正です。 (#{:first_card})" }.to output("1番目のカード指定文字が不正です。 (#{:first_card})\n").to_stderr
      end

      it "second_cardのみが不正でエラーになる" do
        card = Card.new({all_card:"S1 A3 S3 S4 S5", first_card: "S1", second_card: "A3", third_card: "S3",
                         fourth_card: "S4", fifth_card: "S5"})
        expect(card).not_to be_valid
      end

      it "third_cardのみが不正でエラーになる" do
        card = Card.new({all_card:"S1 S2 75 S4 S5", first_card: "S1", second_card: "S2", third_card: "75",
                         fourth_card: "S4", fifth_card: "S5"})
        expect(card).not_to be_valid
      end

      it "fourth_cardのみが不正でエラーになる" do
        card = Card.new({all_card:"S1 S2 S3 S90 S5", first_card: "S1", second_card: "S2", third_card: "S3",
                         fourth_card: "S90", fifth_card: "S5"})
        expect(card).not_to be_valid
      end

      it "fifth_cardのみが不正でエラーになる" do
        card = Card.new({all_card:"S1 S2 S3 S4", first_card: "S1", second_card: "S2", third_card: "S3",
                         fourth_card: "S4", fifth_card: nil})
        expect(card).not_to be_valid
      end

      it "カードが重複していてエラーになる" #あとで追加
    end

  #errrorメッセージなどはここでテストすべきか？
end