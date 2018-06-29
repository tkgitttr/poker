require 'rails_helper'

RSpec.describe "cards/index", type: :view do
  before do
    #何か記述する？
  end

  let(:good_card) do
    Card.new({all_card:"S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2", third_card: "S3",
              fourth_card: "S4", fifth_card: "S5"})
  end
  let(:bad_card) do
    Card.new({all_card:"A1 g2 K3 74", first_card: "A1", second_card: "g2", third_card: "K3",
              fourth_card: "74", fifth_card: nil})
  end

  describe "静的なページ" do
    it "タイトルが表示されている" do
      visit root_path
      expect(page).to have_title 'Home | Pokerhands'
    end

    it "h1のCheck a Poker Hand が表示されている"
    it "フォームが存在する"
    it "submitボタンが存在する"
    it "submit前のカード入力例が表示されている"
    it "submit後のカードのリストが表示されている" do
      # assign(
      # good_card.save
      # render :template => "cards/index.html.erb"
    end

  end
  context "正しいフォーマットでカードを入力したとき"
    it "ストレートフラッシュが表示されている"
    it "フォー・オブ・ア・カインドが表示されている"
    it "フルハウスが表示されている"
    it "フラッシュが表示されている"
    it "ストレートが表示されている"
    it "スリー・オブ・ア・カインドが表示されている"
    it "ツーペアが表示されている"
    it "ワンペアが表示されている"
    it "ハイカードが表示されている"

  context "誤ったフォーマットでカードを入力したとき"
    it "first_cardのエラーメッセージが表示されている"
    it "second_cardのエラーメッセージが表示されている"
    it "third_cardのエラーメッセージが表示されている"
    it "fourth_cardのエラーメッセージが表示されている"
    it "fifth_cardのエラーメッセージが表示されている"
    it "カードの重複エラーが表示されている"
    it "カードが5枚認識されなかったときのエラーが表示されている"

end
