require 'rails_helper'

RSpec.describe CardsController, type: :controller do

  let(:valid_attributes) do
    {all_card: "S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2",
        third_card: "S3", fourth_card: "S4", fifth_card: "S5"}
  end

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_session) do
    {all_card: "S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2",
     third_card: "S3", fourth_card: "S4", fifth_card: "S5", result: "ストレートフラッシュ"}
  end

  describe "GET #index" do
    context "セッションに変数が保存されていないとき"
      it "動作が正常か" do
        get :index, params: {}, session: {}
        expect(response).to be_success
      end

    context "セッションに変数が保存されているとき"
      it "動作が正常か" do
        card = Card.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_success
      end

    context "#createから valid params が送られてきたとき" do
      it "creates a new Card" do
        expect {
          post :index, params: {card: valid_attributes}, session: valid_session
        }.to change(Card, :count).by(1)
      end
    end
  end

  describe "POST #create" do
      it ":all_card にparams が代入される"
      it "@cardに変数が正しく分配される"
      it "カードがスートと数字に分解される"
      it "カードの役を正しく判定する" do
        #これは，Viewのほうで最低限テストしているので省略
      end
      it "session に保存されている"
      it "indexにリダイレクトする" do
        expect(response).to redirect_to(Card.last)
      end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {card: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

end
