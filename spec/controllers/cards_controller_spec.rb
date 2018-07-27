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
     third_card: "S3", fourth_card: "S4", fifth_card: "S56", result: nil}
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
      it "cardにセッションが保存されている" do
        expect(controller.instance_variable_get("@card")).to eq session[:card]
      end
      it "resultにsessionが保存されている" do
        expect(controller.instance_variable_get("@result")).to eq session[:result]
      end
      it "errorsにsessionが保存されている" do
        expect(controller.instance_variable_get("@errors")).to eq session[:card_errors]
      end
    end
    context "セッションに誤った変数が保存されているとき" do
      it "動作が正常" do
        get :index, params: {}, session: invalid_session
        expect(response).to be_success
      end
      it "resultにsessionが保存されていない" do
        get :index, params: {}, session: invalid_session
        expect(controller.instance_variable_get("@result")).to eq nil
      end
      it "errorsにsessionが保存されていない" do
        get :index, params: {}, session: invalid_session
        expect(controller.instance_variable_get("@errors")).to eq nil
      end
    end
  end

  describe "POST #create" do
    context "valid params が送られてきたとき" do
      before do
        post :create, params: {card: valid_attributes}
      end
      it ":all_card にparams が代入される" do
        expect(controller.instance_variable_get("@card")[:all_card]).to eq "S1 S2 S3 S4 S5"
      end
      it "service.saveが成功する" do
        service = CardFormService.new(valid_attributes[:all_card])
        expect(service.save).to eq true
      end
      it "session[:result]に役が保存されている" do
        expect(session[:result]).to eq valid_session[:result]
      end
      it "session[:card_erorrs]にnilが保存されている" do
        expect(session[:card_errors]).to eq nil
      end
      it "session[:all_card]にカードが保存されている" do
        expect(session[:all_card]).to eq valid_session[:all_card]
      end
    end
    context "invalid paramが送られてきたとき" do
      before do
        post :create, params: {card: invalid_attributes}
      end
      it ":all_card にparams が代入されない" do
        expect(controller.instance_variable_get("@card")[:all_card]).not_to eq "S1 S2 S3 S4 S5"
      end
      it "service.saveが失敗する" do
        service = CardFormService.new(invalid_attributes[:all_card])
        expect(service.save).to eq false
      end
      it "session[:result]に何も保存されていない" do
        expect(session[:result]).to eq ""
      end
      it "session[:card_errors]にエラーメッセージが保存されている" do
        expect(session[:card_errors]).not_to eq nil
      end
      it "session[:all_card]にカードが保存されている" do
        expect(session[:all_card]).to eq invalid_session[:all_card]
      end
    end
    it "indexにリダイレクトする" do
      post :create, params: {card: valid_attributes}, session: valid_session
      expect(response).to redirect_to root_path
    end
  end

end
