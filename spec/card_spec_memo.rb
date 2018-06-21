require 'spec_helper'

describe "indexページ" do
  it "Rspecの動作テスト: 1+1=2" do
    expect(1+1).to eq 2
  end

  it "Rspecの動作テスト: 1+1 != 3" do
    expect(1+1).not_to eq 3
  end

  context "indexが初期画面のとき"
  context "正しいフォーマットでカードを入力したとき"
  context "誤ったフォーマットでカードを入力したとき"

end
