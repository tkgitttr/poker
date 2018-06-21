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
      it ":all_cardがバリデーションに通る" do
        expect(good_card).to be_valid(:all_card)
      end
      it ":first_cardがバリデーションに通る" do
        expect(good_card).to be_valid(:first_card)
      end
      it ":second_cardがバリデーションに通る" do
        expect(good_card).to be_valid(:second_card)
      end
      it ":third_cardがバリデーションに通る" do
        expect(good_card).to be_valid(:third)
      end
      it ":fourth_cardがバリデーションに通る" do
        expect(good_card).to be_valid(:fourth_card)
      end
      it ":fifth_cardがバリデーションに通る" do
        expect(good_card).to be_valid(:fifth_card)
      end
    end

    context "誤ったフォーマットで入力したとき" do
      it "バリデーションに通らない" do
        expect(bad_card.errors_on(:first_card, context: :card_format).size).to eql 1
      end
      it "バリデーションに通らない(書き方の試行錯誤)" do
        bad_card[:all_card].valid?
        expect(bad_card.errors(:first_card).size).to eq 1
      end
    end

end