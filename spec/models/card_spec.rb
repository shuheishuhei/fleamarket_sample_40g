require 'rails_helper'
  describe Card do
    describe '#create' do
      it "クレジットカードは登録できます" do
        card = build(:card)
        expect(card).to be_valid
      end
      it "カード番号なしでは登録できません" do
        card = build(:card, customer_id: "")
        card.valid?
        expect(card.errors[:customer_id]).to include("を入力してください")
      end
      it "有効期限なしでは登録できません" do
        card = build(:card, card_id: "")
        card.valid?
        expect(card.errors[:card_id]).to include("を入力してください")
      end
    end
  end

