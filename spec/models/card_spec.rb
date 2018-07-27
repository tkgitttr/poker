# require 'rails_helper'

# RSpec.describe Card, type: :model do
#     let(:good_card) do
#       Card.new({all_card:"S1 S2 S3 S4 S5", first_card: "S1", second_card: "S2", third_card: "S3",
#                 fourth_card: "S4", fifth_card: "S5"})
#     end
#     let(:bad_card) do
#       Card.new({all_card:"A1 g2 K3 74", first_card: "A1", second_card: "g2", third_card: "K3",
#                 fourth_card: "74", fifth_card: nil})
#     end
#     context "正しいフォーマットで入力したとき" do
#       it ":バリデーションに通る" do
#         expect(good_card).to be_valid
#       end
#     end
#     context "誤ったフォーマットで入力したとき" do
#       it "バリデーションに通らない" do
#         bad_card.valid?
#         expect(bad_card.errors.messages.size).to eq 1
#       end
#     end
# end