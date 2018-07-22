require 'rails_helper'

RSpec.describe CardsController, type: :controller do

  let(:valid_attributes) do
    {all_card: "S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2",
        third_card: "S3", fourth_card: "S4", fifth_card: "S5"}
  end

  let(:invalid_attributes) do
    {all_card: "S1 S2 S3 S4 S56", first_card: "S1", second_card: "S2",
     third_card: "S3", fourth_card: "S4", fifth_card: "S56"}
  end00

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
      it "cardにセッションが保存されている" do
        expect(controller.instance_variable_get("@card")).to eq session[:card]
      end
      context "@card.saveが成功したとき" do
        it "resultにsessionが保存されている" do
          card = Card.new(valid_attributes)
          expect(card.save).to be_truthy
          get :index, params: {}, session: valid_session
          expect(controller.instance_variable_get("@result")).to eq session[:result]
        end
      end
      context "@card.saveが失敗したとき" do
        it "resultにsessionが保存されていない" do
          card = Card.new(invalid_attributes)
          expect(card.save).to be_falsey
          get :index, params: {}, session: invalid_session
          expect(controller.instance_variable_get("@result")).not_to eq session[:result]
        end
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
    end
  end

  describe "POST #create" do
    context "valid params が送られてきたとき" do
      it ":all_card にparams が代入される" do
        post :create, params: {card: valid_attributes}
        expect(controller.instance_variable_get("@card")[:all_card]).to eq "S1 S2 S3 S4 S5"
      end
    end
    context "invalid paramが送られてきたとき" do
      it ":all_card にparams が代入されない" do
        post :create, params: {card: invalid_attributes}
        expect(controller.instance_variable_get("@card")[:all_card]).not_to eq "S1 S2 S3 S4 S5"
      end

    end
    it "カードの役を正しく判定する" do
      post :create, params: {card: valid_attributes}
      expect(session[:result]).to eq "ストレートフラッシュ"
    end
    it "session にカードと役が保存されている" do
      post :create, params: {card: valid_attributes}
      expect(session).to include :all_card, :first_card, :second_card, :third_card,
                                 :fourth_card, :fifth_card, :result
    end
    it "indexにリダイレクトする" do
      post :create, params: {card: valid_attributes}, session: valid_session
      expect(response).to redirect_to root_path
    end
  end

end
