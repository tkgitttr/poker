require 'rails_helper'

# before do
#   @params = FactoryBot.attributes_for(:good_cards)
# end
RSpec.describe "Cards", type: :request do

  let(:request_header) do
    { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  let(:good_cards) do
    '{"cards": ["H1 H13 H12 H11 H10", "H9 C9 S9 H2 C12","C13 D12 C11 H8 H7"]}'
  end

  describe "POST /api/v1/cards/check" do
    context "正しいパラメータを送ったとき"
      it "201(create)が返ってくる" do
        post "/api/v1/cards/check", params: good_cards, headers:  request_header #URLはあってる模様．cards.rbには送られているのを確認済み
        expect(response).to have_http_status(201)

        # 最後に消す
        # post "api/v1/cards/check", @params
        # post "api/v1/cards/check", good_cards, request_header
        # post cards_path(format: :json), params: good_cards, headers:  request_header
        # post "/api/v1/cards", params: good_cards, headers:  request_header #表示のURLとしてならあってる
        # post api_v1_path, params: good_cards, headers:  request_header #この形のpathが設定されていない？
      end

      it "Cardレコードが増える" do
        expect {
          post "/api/v1/cards/check", params: good_cards, headers:  request_header
        }.to change { Card.count }.by(3)
      end

    context "間違ったパラメータを送ったとき" do
      it "エラーメッセージが返ってくる"
      it "Cardレコードが増えない"
    end

  end

end
