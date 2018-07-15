require 'rails_helper'

RSpec.describe CardFormService, type: :service do

  let(:valid_attributes) do
    {all_card: "S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2",
     third_card: "S3", fourth_card: "S4", fifth_card: "S5"}
  end
  let(:valid_session) do
    {all_card: "S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2",
     third_card: "S3", fourth_card: "S4", fifth_card: "S5"}
  end

  describe "get_result" do
    before do
      # 下記のように書いてもうまくいかない．順を理解していない
      # allow(CardFormService).to receive(:get_five_cards)
      # allow(CardFormService).to receive(:separate_suit_num)
      # CardFormService.get_result({all_card: "H1 H2 H3 H4 H5"},{})
    end

    it "get_five_cardsメソッドを呼ぶ" do
      # # CardFormServiceのモックを作る
      # card_form_service_mock = double('CardFormService')
      # # get_resultメソッドが呼びだせるようにする
      # allow(card_form_service_mock).to receive(:get_result)
      # allow(card_form_service_mock).to receive(:get_five_cards)
      # expect(card_form_service_mock.get_result).to have_recieved(:get_five_cards)
      # expect(card_form_service_mock).to have_received(:get_five_cards).with({all_card: "H1 H2 H3 H4 H5"}).once

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

    # it "suitsがある" do #メソッドのテストと二重になるから不要
    #   allow(CardFormService).to receive(:separate_suit_num)
    #   allow(CardFormService).to receive(:judge_hand) #なぜかこれを許可しないとテストが通らない
    #   CardFormService.get_result({all_card: "H1 H2 H3 H4 H5"},{})
    #   expect(suits).to eq [1, 2, 3, 4, 5]
    # end
    # it "numsがある"

    it "judge_handメソッドを呼ぶ" do
      allow(CardFormService).to receive(:judge_hand)
      CardFormService.get_result({all_card: "H1 H2 H3 H4 H5"},{})
      expect(CardFormService).to have_received(:judge_hand).once
    end
    # it "resultがある" #二重になるので不要
    it "save_sessionを呼ぶ" do
      allow(CardFormService).to receive(:save_session)
      CardFormService.get_result({all_card: "H1 H2 H3 H4 H5"},{})
      expect(CardFormService).to have_received(:save_session).once
    end
  end

  describe "set_card_form_session" do
    it "cardインスタンスを作る"
    it "session[:all_card]をcard[:all_card]に代入する"
    it "session[:first_card]をcard[:first_card]に代入する"
    it "session[:second_card]をcard[:second_card]に代入する"
    it "session[:third_card]をcard[:third_card]に代入する"
    it "session[:fourth_card]をcard[:fourth_card]に代入する"
    it "session[:fourth_card]をcard[:fourth_card]に代入する"
    it "session[:fifth_card]をcard[:fifth_card]に代入する"
    it "cardを返す"
  end

  describe "get_five_cards" do
    it "card[:first_card]にcard[:all_card]の1つ目が代入される"
    it "card[:second_card]にcard[:all_card]の2つ目が代入される"
    it "card[:third_card]にcard[:all_card]の3つ目が代入される"
    it "card[:fourth_card]にcard[:all_card]の4つ目が代入される"
    it "card[:fifth_card]にcard[:all_card]の5つ目が代入される"
  end

  describe "separate_suit_num" do
    it "suitsにall_cardのスートが配列で格納される" do
      expect(CardFormService.separate_suit_num("H1 H2 H3 H4 H5")[1]).to eq [1, 2, 3, 4, 5]
    end
    it "numsにall_cardの数字が配列で格納される" do
      expect(CardFormService.separate_suit_num("H1 H2 H3 H4 H5")[1]).to eq [1, 2, 3, 4, 5]
    end
    it "suitsとnumsを返す"
  end

  describe "judge_hand" do
    context "スートが1種類かつ数字が5種類，かつ，数字の最大値と最小値の差が4とき" do
      it "hand=ストレートフラッシュを返す"
      it "rank=9"
    end
    context "スートが1種類かつ数字が5種類，かつ，または数字の最小値が１で合計値が４７のとき" do
      it "hand=ストレートフラッシュを返す"
      it "rank=9"
    end
    context "上記の条件外で，同じ数字が４つあるとき" do
      it "hand=フォー・オブ・ア・カインドを返す"
      it "rank=8"
    end
    context "上記の条件外で，数字が２種類のとき" do
      it "hand=フルハウスを返す"
      it "rank=7"
    end
    context "上記の条件外で，スートが1種類のとき" do
      it "hand=フラッシュを返す"
      it "rank=6"
    end
    context "上記の条件外で，数字が5種類，かつ，最大値と最小値の差が4のとき" do
      it "hand=ストレートを返す"
      it "rank=5"
    end
    context "上記の条件外で，数字が5種類，かつ，最小値が1で合計値が47のとき" do
      it "hand=ストレートを返す"
      it "rank=5"
    end
    context "上記の条件外で，同じ数字が3つあるとき" do
      it "hand=スリー・オブ・ア・カインドを返す"
      it "rank=4"
    end
    context "上記の条件外で，同じ数字が２つあるとき" do
      it "hand=ツーペア"
      it "rank=3"
    end
    context "上記の条件外で，同じ数字が1つあるとき" do
      it "hand=ワンペア"
      it "rank=1"
    end
    context "上記の条件に当てはまらなかった場合" do
      it "hand=ハイカード"
      it "rank=1"
    end
    it "handとrankを返す"

  end

  describe "save_session" do
    it "session[:all_card]にcard[:all_card]が代入される"
    it "session[:first_card]にcard[:first_card]が代入される"
    it "session[:second_card]にcard[:second_card]が代入される"
    it "session[:third_card]にcard[:third_card]が代入される"
    it "session[:fourth_card]にcard[:fourth_card]が代入される"
    it "session[:fifth_card]にcard[:fifth_card]が代入される"
    it "session[:result]にresultが代入される"
  end

  describe "valid" do
    it "card_num_validメソッドが呼び出される"
    context "card_num_validがtrueを返すとき" do
      context "first_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される"
      end
      context "second_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される"
      end
      context "third_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される"
      end
      context "fourth_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される"
      end
      context "fifth_cardがinvalidのとき" do
        it "errorsにエラーメッセージとカード名が代入される"
      end
      context "first_card~fifth_cardのいずれかがinvalidのとき" do
        it "errorsにエラーメッセージが追加される"
      end
      it "card_unique_valid?メソッドが呼び出される"
    end
  end

  describe "card_num_valid?" do
    context "all_cardの要素数が5でないとき" do
      it "errorsにエラーメッセージが代入される"
      it "falseを返す"
    end
    context "all_cardの要素数が5のとき" do
      it "trueを返す"
    end
  end

  describe "card_unique_valid?" do
    context "all_cardの種類が4以下のとき" do
      it "errorsにエラーメッセージを代入する"
    end
  end

  describe "distribute_result_errors" do
    it "result（空配列）を作る"
    it "errors（空配列）を作る"
    it "各カードセットごとに，Cardインスタンスを作成する"
    it "get_five_cardsメソッドを呼び出す"
    context "card.saveできたとき" do
      it "resultの要素nに，{card: #[カードセット]}のハッシュを代入"
    end
    context "card.saveに失敗したとき" do
      it "errorsの要素nに，{card: #[カードセット]}のハッシュを代入"
      it "errorsの要素nに，{msg: #[エラーメッセージ]}のハッシュを追加"
    end
    it "result配列からnilを消す"
    it "errors配列からnilを消す"
    it "result,errorsを返す"
  end

end