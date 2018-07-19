require 'rails_helper'

RSpec.describe CardFormService, type: :service do

  let(:valid_attributes) do
    { all_card: "S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2",
     third_card: "S3", fourth_card: "S4", fifth_card: "S5" }
  end
  let(:valid_session) do
    {all_card: "S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2",
     third_card: "S3", fourth_card: "S4", fifth_card: "S5"}
  end
  let(:all_card) do
    {all_card: "S1 S2 S3 S4 S5"}
  end

  describe "get_result" do
    it "get_five_cardsメソッドを呼ぶ" do
      allow(CardFormService).to receive(:get_five_cards)
      CardFormService.get_result({all_card: "H1 H2 H3 H4 H5"},{})
      expect(CardFormService).to have_received(:get_five_cards).once
    end
    it "separate_suit_numメソッドを呼ぶ" do
      allow(CardFormService).to receive(:separate_suit_num)
      allow(CardFormService).to receive(:judge_hand) #なぜかこれを許可しないとテストが通らない
      CardFormService.get_result({all_card: "H1 H2 H3 H4 H5"},{})
      expect(CardFormService).to have_received(:separate_suit_num).once
    end
    it "judge_handメソッドを呼ぶ" do
      allow(CardFormService).to receive(:judge_hand)
      CardFormService.get_result({all_card: "H1 H2 H3 H4 H5"},{})
      expect(CardFormService).to have_received(:judge_hand).once
    end
    it "save_sessionを呼ぶ" do
      allow(CardFormService).to receive(:save_session)
      CardFormService.get_result({all_card: "H1 H2 H3 H4 H5"},{})
      expect(CardFormService).to have_received(:save_session).once
    end
  end

  describe "set_card_form_session" do
    before do
      @card = CardFormService.set_card_from_session(valid_session)
    end
    it "session[:all_card]をcard[:all_card]に代入する" do
      expect(@card[:all_card]).to eq "S1 S2 S3 S4 S5"
    end
    it "session[:first_card]をcard[:first_card]に代入する" do
      expect(@card[:first_card]).to eq "S1"
    end
    it "session[:second_card]をcard[:second_card]に代入する" do
      expect(@card[:second_card]).to eq "S2"
    end
    it "session[:third_card]をcard[:third_card]に代入する" do
      expect(@card[:third_card]).to eq "S3"
    end
    it "session[:fourth_card]をcard[:fourth_card]に代入する" do
      expect(@card[:fourth_card]).to eq "S4"
    end
    it "session[:fourth_card]をcard[:fifth_card]に代入する" do
      expect(@card[:fifth_card]).to eq "S5"
    end
  end

  describe "get_five_cards" do
    before do
      @card = all_card
      CardFormService.get_five_cards(@card)
    end
    it "card[:first_card]にcard[:all_card]の1つ目が代入される" do
      expect(@card[:first_card]).to eq "S1"
    end
    it "card[:second_card]にcard[:all_card]の2つ目が代入される" do
      expect(@card[:second_card]).to eq "S2"
    end
    it "card[:third_card]にcard[:all_card]の3つ目が代入される" do
      expect(@card[:third_card]).to eq "S3"
    end
    it "card[:fourth_card]にcard[:all_card]の4つ目が代入される" do
      expect(@card[:fourth_card]).to eq "S4"
    end
    it "card[:fifth_card]にcard[:all_card]の5つ目が代入される" do
      expect(@card[:fifth_card]).to eq "S5"
    end
  end

  describe "separate_suit_num" do
    before do
      @suits, @nums = CardFormService.separate_suit_num(all_card[:all_card])
    end
    it "suitsにall_cardのスートが配列で格納される" do
      expect(@suits).to eq ["S", "S", "S", "S", "S"]
    end
    it "numsにall_cardの数字が配列で格納される" do
      expect(@nums).to eq [1, 2, 3, 4, 5]
    end
  end

  describe "judge_hand" do
    context "スートが1種類かつ数字が5種類，かつ，数字の最大値と最小値の差が4とき" do
      before do
        @suits = ["S", "S", "S", "S", "S"]
        @nums = [2, 6, 4, 5, 3]
        @hand,@rank = CardFormService.judge_hand(@suits,@nums)
      end
      it "hand=ストレートフラッシュを返す" do
        expect(@hand).to eq "ストレートフラッシュ"
      end
      it "rank=9" do
        expect(@rank).to eq 9
      end
    end
    context "スートが1種類かつ数字が5種類，かつ，または数字の最小値が１で合計値が４７のとき" do
      before do
        @suits = ["S", "S", "S", "S", "S"]
        @nums = [13, 12, 11, 1, 10]
        @hand,@rank = CardFormService.judge_hand(@suits,@nums)
      end
      it "hand=ストレートフラッシュを返す" do
        expect(@hand).to eq "ストレートフラッシュ"
      end
      it "rank=9" do
        expect(@rank).to eq 9
      end
    end
    context "上記の条件外で，同じ数字が４つあるとき" do
      before do
        @suits = ["S", "S", "C", "D", "H"]
        @nums = [2, 6, 2, 2, 2]
        @hand,@rank = CardFormService.judge_hand(@suits,@nums)
      end
      it "hand=フォー・オブ・ア・カインドを返す" do
        expect(@hand).to eq "フォー・オブ・ア・カインド"
      end
      it "rank=8" do
        expect(@rank).to eq 8
      end
    end
    context "上記の条件外で，数字が２種類のとき" do
      before do
        @suits = ["S", "S", "C", "D", "H"]
        @nums = [2, 6, 2, 6, 2]
        @hand,@rank = CardFormService.judge_hand(@suits,@nums)
      end
      it "hand=フルハウスを返す" do
        expect(@hand).to eq "フルハウス"
      end
      it "rank=7" do
        expect(@rank).to eq 7
      end
    end
    context "上記の条件外で，スートが1種類のとき" do
      before do
        @suits = ["D", "D", "D", "D", "D"]
        @nums = [2, 6, 5, 4, 9]
        @hand,@rank = CardFormService.judge_hand(@suits,@nums)
      end
      it "hand=フラッシュを返す" do
        expect(@hand).to eq "フラッシュ"
      end
      it "rank=6" do
        expect(@rank).to eq 6
      end
    end
    context "上記の条件外で，数字が5種類，かつ，最大値と最小値の差が4のとき" do
      before do
        @suits = ["S", "D", "H", "D", "C"]
        @nums = [2, 6, 5, 4, 3]
        @hand,@rank = CardFormService.judge_hand(@suits,@nums)
      end
      it "hand=ストレートを返す" do
        expect(@hand).to eq "ストレート"
      end
      it "rank=5" do
        expect(@rank).to eq 5
      end
    end
    context "上記の条件外で，数字が5種類，かつ，最小値が1で合計値が47のとき" do
      before do
        @suits = ["S", "D", "H", "D", "C"]
        @nums = [1, 12, 13, 10, 11]
        @hand,@rank = CardFormService.judge_hand(@suits,@nums)
      end
      it "hand=ストレートを返す" do
        expect(@hand).to eq "ストレート"
      end
      it "rank=5" do
        expect(@rank).to eq 5
      end
    end
    context "上記の条件外で，同じ数字が3つあるとき" do
      before do
        @suits = ["S", "D", "H", "D", "C"]
        @nums = [1, 12, 12, 10, 12]
        @hand,@rank = CardFormService.judge_hand(@suits,@nums)
      end
      it "hand=スリー・オブ・ア・カインドを返す" do
        expect(@hand).to eq "スリー・オブ・ア・カインド"
      end
      it "rank=4" do
        expect(@rank).to eq 4
      end
    end
    context "上記の条件外で，同じ数字が２つあるとき" do
      before do
        @suits = ["S", "D", "H", "D", "C"]
        @nums = [1, 12, 10, 10, 12]
        @hand,@rank = CardFormService.judge_hand(@suits,@nums)
      end
      it "hand=ツーペア" do
        expect(@hand).to eq "ツーペア"
      end
      it "rank=3" do
        expect(@rank).to eq 3
      end
    end
    context "上記の条件外で，同じ数字が1つあるとき" do
      before do
        @suits = ["S", "D", "H", "D", "C"]
        @nums = [1, 12, 10, 5, 12]
        @hand,@rank = CardFormService.judge_hand(@suits,@nums)
      end
      it "hand=ワンペア" do
        expect(@hand).to eq "ワンペア"
      end
      it "rank=2" do
        expect(@rank).to eq 2
      end
    end
    context "上記の条件に当てはまらなかった場合" do
      before do
        @suits = ["S", "D", "H", "D", "C"]
        @nums = [1, 7, 10, 5, 12]
        @hand,@rank = CardFormService.judge_hand(@suits,@nums)
      end
      it "hand=ハイカード" do
        expect(@hand).to eq "ハイカード"
      end
      it "rank=1" do
        expect(@rank).to eq 1
      end
    end
  end

  describe "save_session" do
    before do
      @session = {}
      CardFormService.save_session(@session, valid_attributes, "ワンペア")
    end
    it "session[:all_card]にcard[:all_card]が代入される" do
      expect(@session[:all_card]).to eq "S1 S2 S3 S4 S5"
    end
    it "session[:first_card]にcard[:first_card]が代入される" do
      expect(@session[:first_card]).to eq "S1"
    end
    it "session[:second_card]にcard[:second_card]が代入される" do
      expect(@session[:second_card]).to eq "S2"
    end
    it "session[:third_card]にcard[:third_card]が代入される" do
      expect(@session[:third_card]).to eq "S3"
    end
    it "session[:fourth_card]にcard[:fourth_card]が代入される" do
      expect(@session[:fourth_card]).to eq "S4"
    end
    it "session[:fifth_card]にcard[:fifth_card]が代入される" do
      expect(@session[:fifth_card]).to eq "S5"
    end
    it "session[:result]にresultが代入される" do
      expect(@session[:result]).to eq "ワンペア"
    end
  end

  describe "valid" do
    before do
      @errors = Card.new.errors()
    end
    it "card_num_valid?メソッドが呼び出される" do
      allow(CardFormService).to receive(:card_num_valid?)
      CardFormService.valid("","","","","","",@errors)
      expect(CardFormService).to have_received(:card_num_valid?).once
    end
    context "card_num_validがtrueを返すとき" do
      context "カードが正常のとき" do
        it "エラーメッセージが出ない" do
          CardFormService.valid("S1 S2 S3 S4 S5","S1","S2","S3","S4","S5",@errors)
          expect(@errors.messages.values[0]).to eq nil
        end
      end
      context "first_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される" do
          CardFormService.valid("DD S2 S3 S4 S5","DD","S2","S3","S4","S5",@errors)
          expect(@errors.messages.values[0]).to include "1番目のカード指定文字が不正です。 (DD)"
        end
      end
      context "second_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される" do
          CardFormService.valid("S1 S90 S3 S4 S5","S1","S90","S3","S4","S5",@errors)
          expect(@errors.messages.values[0]).to include "2番目のカード指定文字が不正です。 (S90)"
        end
      end
      context "third_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される" do
          CardFormService.valid("S1 S2 G3 S4 S5","S1","S2","G3","S4","S5",@errors)
          expect(@errors.messages.values[0]).to include "3番目のカード指定文字が不正です。 (G3)"
        end
      end
      context "fourth_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される" do
          CardFormService.valid("S1 S2 S3 s4 S5","S1","S2","S3","s4","S5",@errors)
          expect(@errors.messages.values[0]).to include "4番目のカード指定文字が不正です。 (s4)"
        end
      end
      context "fifth_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される" do
          CardFormService.valid("S1 S2 S3 S4 f","S1","S2","S3","S4","f",@errors)
          expect(@errors.messages.values[0]).to include "5番目のカード指定文字が不正です。 (f)"
        end
      end
      context "first_card~fifth_cardのいずれかがinvalidのとき" do
        it "errorsにエラーメッセージが追加される" do
          CardFormService.valid("S1 S2 S3 S4 f","S1","S2","S3","S4","f",@errors)
          expect(@errors.messages.values[0]).to include "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        end
      end
      it "card_unique_valid?メソッドが呼び出される" do
        allow(CardFormService).to receive(:card_unique_valid?)
        CardFormService.valid("S1 S2 S3 S4 S5","S1","S2","S3","S4","S5",@errors)
        expect(CardFormService).to have_received(:card_unique_valid?).once
      end
    end
    context "card_num_validがfalseを返すとき" do
      it "返り値がnil" do
        allow(CardFormService).to receive(:card_num_valid?).and_return false
        ans = CardFormService.valid("S1 S2 S3 S4 S5","S1","S2","S3","S4","S5",@errors)
        expect(ans).to be_falsy
      end
    end
  end

  describe "card_num_valid?" do
    before do
      @errors = Card.new.errors()
    end
    context "all_cardの要素数が5でないとき" do
      before do
        @ans = CardFormService.card_num_valid?("S1 S2 S3 S4",@errors)
      end
      it "errorsにエラーメッセージが代入される" do
        expect(@errors.messages.values[0]).to include '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）'
      end
      it "falseを返す" do
        expect(@ans).to be_falsy
      end
    end
    context "all_cardの要素数が5のとき" do
      it "trueを返す" do
        expect(CardFormService.card_num_valid?("S1 S2 S3 S4 S5",@errors)).to be_truthy
      end
    end
  end

  describe "card_unique_valid?" do
    before do
      @errors = Card.new.errors()
    end
    context "all_cardの種類が4以下のとき(カードが重複しているとき)" do
      it "errorsにエラーメッセージを代入する" do
        CardFormService.card_unique_valid?("S1 S2 S3 S4 S1",@errors)
        expect(@errors.messages.values[0]).to include "カードが重複しています。"
      end
    end
    context "all_cardの種類が5つあるとき" do
      it "nilを返す" do
        expect(CardFormService.card_unique_valid?("S1 S2 S3 S4 S5",@errors)).to eq nil
      end
    end
  end

  describe "distribute_result_errors" do
    let(:good_cards_params) do
    { cards: ["S1 S2 S3 S4 S5", "H1 H2 H3 H4 H6"] }
    end
    it "get_five_cardsメソッドを呼び出す" do
      allow(CardFormService).to receive(:get_five_cards)
      CardFormService.distribute_result_errors(good_cards_params)
      expect(CardFormService).to have_received(:get_five_cards).twice
    end
    context "card.saveできたとき" do
      it "Cardモデルに要素が増える" do
        expect{CardFormService.distribute_result_errors(good_cards_params)}.to change(Card, :count).by(2)
      end
      it "resultに，{card: #[カードセット]}のハッシュを代入" do
        result,  = CardFormService.distribute_result_errors(good_cards_params)
        expect(result).to include({ card: "S1 S2 S3 S4 S5" })
        expect(result).to include({ card: "H1 H2 H3 H4 H6" })
      end
    end
    context "card.saveに失敗したとき" do
      before do
        @invalid_cards_params = {cards: ["S1 S2 G4 S4 S5", "", "H1 H2 H3 H4"]}
        result, @errors  = CardFormService.distribute_result_errors(@invalid_cards_params)
      end
      it "errorsに，{card: #[カードセット]}のハッシュを代入" do
        expect(@errors[0][:card]).to include "S1 S2 G4 S4 S5"
        expect(@errors[1][:card]).to include ""
        expect(@errors[2][:card]).to include "H1 H2 H3 H4"
      end
      it "errorsの要素nに，{msg: #[エラーメッセージ]}のハッシュを追加" do
        expect(@errors[0][:msg]).to include "  3番目のカード指定文字が不正です。 (G4)"
        expect(@errors[1][:msg]).to include "  5つのカード指定文字を半角スペース区切りで入力してください。（例：\"S1 H3 D9 C13 S11\"）"
        expect(@errors[2][:msg]).to include "  5つのカード指定文字を半角スペース区切りで入力してください。（例：\"S1 H3 D9 C13 S11\"）"
      end
    end
    it "result配列にnilがない" do
      result, errors  = CardFormService.distribute_result_errors({cards: ["S1 S2 G4 S4 S5", "", "H1 H2 H3 H4 H5"]})
      expect(result).not_to include nil
    end
    it "errors配列にnilがない" do
      result, errors  = CardFormService.distribute_result_errors({cards: ["S1 S2 G4 S4 S5", "", "H1 H2 H3 H4 H5"]})
      expect(errors).not_to include nil
    end
  end

end