require 'rails_helper'

RSpec.describe CardsController, type: :controller do

  let(:valid_attributes) do
    {all_card: "S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2",
        third_card: "S3", fourth_card: "S4", fifth_card: "S5"}
  end

  let(:invalid_attributes) do
    {all_card: "S1 S2 S3 S4 S56", first_card: "S1", second_card: "S2",
     third_card: "S3", fourth_card: "S4", fifth_card: "S56"}
  end

  let(:valid_session) do
    {all_card: "S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2",
     third_card: "S3", fourth_card: "S4", fifth_card: "S5", result: "ストレートフラッシュ"}
  end

  let(:invalid_session) do
    {all_card: "S1 S2 S3 S4 S56", first_card: "S1", second_card: "S2",
     third_card: "S3", fourth_card: "S4", fifth_card: "S56", result: "ハイカード"}
  end

  describe "GET #index" do
    context "セッションに変数が保存されていないとき"
      it "動作が正常" do
        get :index, params: {}, session: {}
        expect(response).to be_success
      end

    context "セッションに正しい変数が保存されているとき" do
      it "動作が正常" do
        get :index, params: {}, session: valid_session
        expect(response).to be_success
      end
      it "resultにsessionが保存されている" do
        get :index, params: {}, session: valid_session
        expect(controller.instance_variable_get("@result")).to eq session[:result]
      end
    end

    context "セッションに誤った変数が保存されているとき" do
      it "動作が正常" do
        get :index, params: {}, session: invalid_session
        expect(response).to be_success
      end
      it "resultにsessionが保存されていない" do
        get :index, params: {}, session: invalid_session
        expect(controller.instance_variable_get("@result")).to eq ""
      end
    end

    context "#createから valid params が送られてきたとき" do
      it "カードを保存" do
        expect {
          post :index, params: {card: valid_attributes}, session: valid_session
        }.to change(Card, :count).by(1)
      end
      end

    context "#createから invalid params が送られてきたとき" do
      it "カードを保存しない" do
        expect {
          post :index, params: {card: invalid_attributes}, session: invalid_session
        }.to change(Card, :count).by(0)
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
        post :create, params: {card: valid_attributes}, session: valid_session
        expect(response).to redirect_to root_path
      end
  end

end
