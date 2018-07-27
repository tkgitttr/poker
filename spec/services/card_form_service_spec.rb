require 'rails_helper'

RSpec.describe CardFormService, type: :service do

  let(:valid_attributes) do
    { all_card: "S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2",
     third_card: "S3", fourth_card: "S4", fifth_card: "S5" }
  end
  let(:invalid_attributes) do
    { all_card: "S1 S2 S3 S4 S55", first_card: "S1", second_card: "S2",
      third_card: "S3", fourth_card: "S4", fifth_card: "S55" }
  end
  let(:valid_session) do
    {all_card: "S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2",
     third_card: "S3", fourth_card: "S4", fifth_card: "S5"}
  end
  let(:all_card) do
    {all_card: "S1 S2 S3 S4 S5"}
  end

  describe "initialize" do
    before do
      @service = CardFormService.new(valid_attributes[:all_card])
    end
    it "@cardに引数のカードが保存されている" do
      expect(@service.instance_variable_get("@card")).to eq valid_attributes[:all_card]
    end
    it "get_five_cardの結果が返っている" do
      expect(@service.first_card).to eq valid_attributes[:first_card]
      expect(@service.second_card).to eq valid_attributes[:second_card]
      expect(@service.third_card).to eq valid_attributes[:third_card]
      expect(@service.fourth_card).to eq valid_attributes[:fourth_card]
      expect(@service.fifth_card).to eq valid_attributes[:fifth_card]
    end
    it "suitとnumを持っている" do
      expect(@service.instance_variable_get("@suits")).to eq ["S", "S", "S", "S", "S"]
      expect(@service.instance_variable_get("@nums")).to eq [1, 2, 3, 4, 5]
    end
    it "役を持っている" do
      expect(@service.instance_variable_get("@hand")).to eq "ストレートフラッシュ"
      expect(@service.instance_variable_get("@rank")).to eq 9
    end
  end

  describe "save" do
    context "validのとき" do
      before do
        @service = CardFormService.new(valid_attributes[:all_card])
      end
      it "Cardモデルのデータが１つ増えている" do
        expect{@service.save}.to change(Card, :count).by(1)
      end
      it "trueを返す" do
        expect(@service.save).to eq true
      end
    end
    context "invalidのとき" do
      before do
        @service = CardFormService.new(invalid_attributes[:all_card])
      end
      it "Cardモデルのデータが増えていない" do
        expect{@service.save}.to change(Card, :count).by(0)
      end
      it "falseを返す" do
        expect(@service.save).to eq false
      end
    end
  end

  describe "valid?" do
    context "card_num_valid?がtrueを返すとき" do
      context "カードが正常のとき" do
        it "エラーメッセージが出ない" do
          service = CardFormService.new("S1 S2 S3 S4 S5")
          service.send(:valid?)
          expect(service.error_msg).to eq []
        end
      end
      context "first_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される" do
          service = CardFormService.new("DD S2 S3 S4 S5")
          expect(service.send(:valid?)).to eq false
          expect(service.error_msg).to include "1番目のカード指定文字が不正です。 (DD)"
          expect(service.error_msg).to include "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        end
      end
      context "second_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される" do
          service = CardFormService.new("S1 S22 S3 S4 S5")
          expect(service.send(:valid?)).to eq false
          expect(service.error_msg).to include "2番目のカード指定文字が不正です。 (S22)"
          expect(service.error_msg).to include "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        end
      end
      context "third_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される" do
          service = CardFormService.new("S1 S2 S33 S4 S5")
          expect(service.send(:valid?)).to eq false
          expect(service.error_msg).to include "3番目のカード指定文字が不正です。 (S33)"
          expect(service.error_msg).to include "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        end
      end
      context "fourth_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される" do
          service = CardFormService.new("S1 S2 S3 S44 S5")
          expect(service.send(:valid?)).to eq false
          expect(service.error_msg).to include "4番目のカード指定文字が不正です。 (S44)"
          expect(service.error_msg).to include "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        end
      end
      context "fifth_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される" do
          service = CardFormService.new("S1 S2 S3 S4 S55")
          expect(service.send(:valid?)).to eq false
          expect(service.error_msg).to include "5番目のカード指定文字が不正です。 (S55)"
          expect(service.error_msg).to include "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        end
      end
      context "個々のカードにはエラーが出ていないとき" do
        context "card_unique_validがtrueのとき" do
          it "trueを返す" do
            service = CardFormService.new(valid_attributes[:all_card])
            expect(service.send(:card_unique_valid?)).to eq true #本当はtrueをモックで返す？
            expect(service.send(:valid?)).to eq true
          end
        end
        context "card_unique_validがfalseのとき" do
          it "falseを返す" do
            service = CardFormService.new("S1 S2 S3 S4 S1")
            expect(service.send(:card_unique_valid?)).to eq false
            expect(service.send(:valid?)).to eq false
          end
        end
      end
    end
    context "card_num_valid?がfalseを返すとき" do
      it "返り値がnil" do
        service = CardFormService.new("S1 S2 S3 S4")
        expect(service.send(:valid?)).to eq nil
      end
    end
  end

  describe "card_num_valid?" do
    context "カードが半角区切りで5枚入力されているとき" do
      it "trueを返す" do
        service = CardFormService.new(valid_attributes[:all_card])
        expect(service.send(:card_num_valid?)).to eq true
      end
    end
    context "カードが半角区切りで5枚入力されていないとき" do
      it "falseを返す" do
        service = CardFormService.new("S1 S2 S3 S4")
        expect(service.send(:card_num_valid?)).to eq false
      end
    end
  end

  describe "card_unique_valid" do
    context "カードが重複していないとき" do
      it "trueを返す" do
        service = CardFormService.new(valid_attributes[:all_card])
        expect(service.send(:card_unique_valid?)).to eq true
      end
    end
    context "カードが重複しているとき" do
      it "falseを返す" do
        service = CardFormService.new("S1 S2 S3 S4 S1")
        expect(service.send(:card_unique_valid?)).to eq false
      end
    end
  end

  describe "judge_hand" do
    context "スートが1種類かつ数字が5種類，かつ，数字の最大値と最小値の差が4とき" do
      before do
        @service = CardFormService.new("S6 S2 S3 S4 S5")
      end
      it "hand=ストレートフラッシュを返す" do
        expect(@service.hand).to eq "ストレートフラッシュ"
      end
      it "rank=9" do
        expect(@service.rank).to eq 9
      end
    end
    context "スートが1種類かつ数字が5種類，かつ，または数字の最小値が１で合計値が４７のとき" do
      before do
        @service = CardFormService.new("S13 S12 S11 S10 S1")
      end
      it "hand=ストレートフラッシュを返す" do
        expect(@service.hand).to eq "ストレートフラッシュ"
      end
      it "rank=9" do
        expect(@service.rank).to eq 9
      end
    end
    context "上記の条件外で，同じ数字が４つあるとき" do
      before do
        @service = CardFormService.new("S13 C7 D7 H7 S7")
      end
      it "hand=フォー・オブ・ア・カインドを返す" do
        expect(@service.hand).to eq "フォー・オブ・ア・カインド"
      end
      it "rank=8" do
        expect(@service.rank).to eq 8
      end
    end
    context "上記の条件外で，数字が２種類のとき" do
      before do
        @service = CardFormService.new("S5 C7 D7 H5 S7")
      end
      it "hand=フルハウスを返す" do
        expect(@service.hand).to eq "フルハウス"
      end
      it "rank=7" do
        expect(@service.rank).to eq 7
      end
    end
    context "上記の条件外で，スートが1種類のとき" do
      before do
        @service = CardFormService.new("S1 S7 S8 S5 S10")
      end
      it "hand=フラッシュを返す" do
        expect(@service.hand).to eq "フラッシュ"
      end
      it "rank=6" do
        expect(@service.rank).to eq 6
      end
    end
    context "上記の条件外で，数字が5種類，かつ，最大値と最小値の差が4のとき" do
      before do
        @service = CardFormService.new("S9 H7 D8 S6 S10")
      end
      it "hand=ストレートを返す" do
        expect(@service.hand).to eq "ストレート"
      end
      it "rank=5" do
        expect(@service.rank).to eq 5
      end
    end
    context "上記の条件外で，数字が5種類，かつ，最小値が1で合計値が47のとき" do
      before do
        @service = CardFormService.new("S1 H10 D13 S12 S11")
      end
      it "hand=ストレートを返す" do
        expect(@service.hand).to eq "ストレート"
      end
      it "rank=5" do
        expect(@service.rank).to eq 5
      end
    end
    context "上記の条件外で，同じ数字が3つあるとき" do
      before do
        @service = CardFormService.new("S1 H10 D11 C11 S11")
      end
      it "hand=スリー・オブ・ア・カインドを返す" do
        expect(@service.hand).to eq "スリー・オブ・ア・カインド"
      end
      it "rank=4" do
        expect(@service.rank).to eq 4
      end
    end
    context "上記の条件外で，同じ数字が２つあるとき" do
      before do
        @service = CardFormService.new("S9 H10 D9 C11 S11")
      end
      it "hand=ツーペア" do
        expect(@service.hand).to eq "ツーペア"
      end
      it "rank=3" do
        expect(@service.rank).to eq 3
      end
    end
    context "上記の条件外で，同じ数字が1つあるとき" do
      before do
        @service = CardFormService.new("S1 H10 D8 C11 S11")
      end
      it "hand=ワンペア" do
        expect(@service.hand).to eq "ワンペア"
      end
      it "rank=2" do
        expect(@service.rank).to eq 2
      end
    end
    context "上記の条件に当てはまらなかった場合" do
      before do
        @service = CardFormService.new("S1 H10 D8 C11 S7")
      end
      it "hand=ハイカード" do
        expect(@service.hand).to eq "ハイカード"
      end
      it "rank=1" do
        expect(@service.rank).to eq 1
      end
    end
  end
end