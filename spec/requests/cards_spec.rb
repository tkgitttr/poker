require 'rails_helper'

# before do
#   #Factory.Botがうまく使えないため，ベタ打ちで
#   @params = FactoryBot.attributes_for(:good_cards)
# end

RSpec.describe "API::Ver1::Cards", type: :request do
  let(:request_header) do
    { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end
  let(:good_cards) do
    '{"cards": ["H1 H13 H12 H11 H10", "H9 C9 S9 H2 C12","C13 D12 C11 H8 H7"]}'
  end
  let(:wrong_cards) do
    '{"cards": ["H1 H13 H12 H11 H10", "H9 C9 S95 G2 C12","C13 D12 C11 H8 H7"]}'
  end

  describe "POST /api/v1/cards/check" do
    context "正しいパラメータを送ったとき" do
      before do
        post "/api/v1/cards/check", params: good_cards, headers:  request_header #URLはあってる模様．cards.rbには送られているのを確認済み
      end
      it "201(create)が返ってくる" do
        expect(response).to have_http_status(201)
      end
      it "Cardレコードが増える" do
        expect {
          post "/api/v1/cards/check", params: good_cards, headers:  request_header
        }.to change { Card.count }.by(3)
      end
      it "役,bestを含むJSONが返ってくる" do
        body = JSON.parse(response.body)
        expect(body["result"][0]["card"]).to eq "H1 H13 H12 H11 H10"
        expect(body["result"][0]["hand"]).to eq "ストレートフラッシュ"
        expect(body["result"][0]["best"]).to eq true
        expect(body["result"][1]["card"]).to eq "H9 C9 S9 H2 C12"
        expect(body["result"][1]["hand"]).to eq "スリー・オブ・ア・カインド"
        expect(body["result"][1]["best"]).to eq false
        expect(body["result"][2]["card"]).to eq "C13 D12 C11 H8 H7"
        expect(body["result"][2]["hand"]).to eq "ハイカード"
        expect(body["result"][2]["best"]).to eq false
      end
    end
    context "間違ったパラメータを含むリクエストを送ったとき" do
      before do
        post "/api/v1/cards/check", params: wrong_cards, headers:  request_header
      end
      it "エラーメッセージを含むJSONが返ってくる" do
        body = JSON.parse(response.body)
        expect(body["result"][0]["card"]).to eq "H1 H13 H12 H11 H10"
        expect(body["result"][0]["hand"]).to eq "ストレートフラッシュ"
        expect(body["result"][0]["best"]).to eq true
        expect(body["result"][1]["card"]).to eq "C13 D12 C11 H8 H7"
        expect(body["result"][1]["hand"]).to eq "ハイカード"
        expect(body["result"][1]["best"]).to eq false
        expect(body["error"][0]["card"]).to eq "H9 C9 S95 G2 C12"
        expect(body["error"][0]["msg"]).to eq ["  3番目のカード指定文字が不正です。 (S95)","  4番目のカード指定文字が不正です。 (G2)","  半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"]
      end
      it "正しいCardセットの数だけCardレコードが増える" do
        expect {
          post "/api/v1/cards/check", params: wrong_cards, headers:  request_header
        }.to change { Card.count }.by(2) #2セット：正，1セット：誤　
      end
    end
  end
end
