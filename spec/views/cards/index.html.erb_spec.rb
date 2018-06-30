require 'rails_helper'

RSpec.describe "cards/index", type: :view do
  before do
    visit root_path
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
      expect(page).to have_title "Poker"
    end
    it "headerがある" do
      #headの中のtitleタグにあるという記述はできるか？
      expect(page).to have_selector 'title', text: "Home | Pokerhands"
    end
    it "h1のCheck a Poker Hand が表示されている" do
      expect(page).to have_selector "h1", text: "Check a Poker Hand"
    end
    it "フォームにsubmit前のカード入力例が表示されている"do
      # うまくいかない
      # expect(page).to have_field "card[all_card]", with: "S10 H11 D12 C13 H1"
      # textarea = find(card[all_card])
      # expect(textarea.value).to match "S10 H11 D12 C13 H1"
    end
    it "submitボタンが存在する" do
      expect(page).to have_button 'check'
    end
    it "submit後のカードのリストが表示されている" do
      fill_in "card[all_card]", with: "S1 S2 S3 S4 S5"
      click_button "check"
      expect(page).to have_field "card[all_card]", with: "S1 S2 S3 S4 S5"
    end
  end

  context "正しいフォーマットでカードを入力したとき" do
    it "ストレートフラッシュが表示されている" do
      fill_in "card[all_card]", with: "S1 S2 S3 S4 S5"
      click_button "check"
      expect(page).to have_selector 'h2', text: "ストレートフラッシュ"
    end
    it "フォー・オブ・ア・カインドが表示されている" do
      fill_in "card[all_card]", with: "S1 D1 C1 H1 S5"
      click_button "check"
      expect(page).to have_selector 'h2', text: "フォー・オブ・ア・カインド"
    end
    it "フルハウスが表示されている" do
      fill_in "card[all_card]", with: "S1 D1 C1 H2 S2"
      click_button "check"
      expect(page).to have_selector 'h2', text: "フルハウス"
    end
    it "フラッシュが表示されている" do
      fill_in "card[all_card]", with: "S1 S2 S6 S10 S13"
      click_button "check"
      expect(page).to have_selector 'h2', text: "フラッシュ"
    end
    it "ストレートが表示されている" do
      fill_in "card[all_card]", with: "S6 D2 C4 S3 C5"
      click_button "check"
      expect(page).to have_selector 'h2', text: "ストレート"
    end
    it "スリー・オブ・ア・カインドが表示されている" do
      fill_in "card[all_card]", with: "S1 D1 C1 H5 S13"
      click_button "check"
      expect(page).to have_selector 'h2', text: "スリー・オブ・ア・カインド"
    end
    it "ツーペアが表示されている" do
      fill_in "card[all_card]", with: "H5 D1 C1 S7 S5"
      click_button "check"
      expect(page).to have_selector 'h2', text: "ツーペア"
    end
    it "ワンペアが表示されている" do
      fill_in "card[all_card]", with: "S1 D9 C10 H1 S5"
      click_button "check"
      expect(page).to have_selector 'h2', text: "ワンペア"
    end
    it "ハイカードが表示されている" do
      fill_in "card[all_card]", with: "S1 D9 C13 H2 S5"
      click_button "check"
      expect(page).to have_selector 'h2', text: "ハイカード"
    end
  end

  context "誤ったフォーマットでカードを入力したとき" do
    it "first_cardのエラーメッセージが表示されている" do
      fill_in "card[all_card]", with: "S20 D1 C1 H1 S5"
      click_button "check"
      expect(page).to have_selector 'div#error_explanation', text: "1番目のカード指定文字が不正です。 (S20)"
      expect(page).to have_selector 'div#error_explanation', text: "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end
    it "second_cardのエラーメッセージが表示されている" do
      fill_in "card[all_card]", with: "S2 11 C1 H1 S5"
      click_button "check"
      expect(page).to have_selector 'div#error_explanation', text: "2番目のカード指定文字が不正です。 (11)"
      expect(page).to have_selector 'div#error_explanation', text: "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end
    it "third_cardのエラーメッセージが表示されている" do
      fill_in "card[all_card]", with: "S2 D1 hhh H1 S5"
      click_button "check"
      expect(page).to have_selector 'div#error_explanation', text: "3番目のカード指定文字が不正です。 (hhh)"
      expect(page).to have_selector 'div#error_explanation', text: "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end
    it "fourth_cardのエラーメッセージが表示されている" do
      fill_in "card[all_card]", with: "S2 D1 C1 K3 S5"
      click_button "check"
      expect(page).to have_selector 'div#error_explanation', text: "4番目のカード指定文字が不正です。 (K3)"
      expect(page).to have_selector 'div#error_explanation', text: "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end
    it "fifth_cardのエラーメッセージが表示されている" do
      fill_in "card[all_card]", with: "S20 D1 C1 H1 l"
      click_button "check"
      expect(page).to have_selector 'div#error_explanation', text: "5番目のカード指定文字が不正です。 (l)"
      expect(page).to have_selector 'div#error_explanation', text: "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end
    it "カードの重複エラーが表示されている" do
      fill_in "card[all_card]", with: "S2 D1 C1 H1 S2"
      click_button "check"
      expect(page).to have_selector 'div#error_explanation', text: "カードが重複しています。"
    end
    it "カードが5枚認識されなかったときのエラーが表示されている" do
      fill_in "card[all_card]", with: "S2 D1 C1 H1"
      click_button "check"
      expect(page).to have_selector 'div#error_explanation', text: '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）'
    end
  end
end
