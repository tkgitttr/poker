require 'spec_helper'

describe "indexページ" do
  it "Rspecの動作テスト: 1+1=2" do
    expect( 1 + 1 ).to eq 2
  end

  it "Rspecの動作テスト: 1+1 != 3" do
    expect(1+1).not_to eq 3
  end

  context "indexが初期画面のとき"
  context "正しいフォーマットでカードを入力したとき"
  context "誤ったフォーマットでカードを入力したとき"

end

describe "Cardモデル" do
  describe "all_cardカラム" do
    let(:good_card) do
      Card.new({all_card: "S1 S2 S3 S4 S5"})
    end
    let(:bad_card) do
      Card.new({all_card: "A1 G2 E3 R4 T5"})
    end

    context "正しいフォーマットで入力したとき" do
      it "バリデーションに通る" do
        good_card[:all_card].valid?
        expect(good_card.errors.message).not_to include()
      end
    end
  end
end