require 'rails_helper'


describe Item do
  describe "#create" do
    user = create(:user)

    
    
    it "商品画像、商品名、商品説明、カテゴリー、商品の状態、配送料の負担、配送方法、発送物の地域、発送までの日数、価格が入力されていれば出品可能" do
      item = build(:item)
      expect(item).to be_valid
    end

    it "商品ネームが空では登録できない" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "商品名が40文字を超えている場合は出品できない" do
      item = build(:item, name: "a" * 41)
      item.valid?
      expect(item.errors[:name]).to include("is too long (maximum is 40 characters)")
    end

    it "商品説明が空では出品できない" do
      item = build(:item, introduction: "")
      item.valid?
      expect(item.errors[:introduction]).to include("can't be blank")
    end

    it "商品説明が1000文字を超えている場合は登録できない" do
      item = build(:item, introduction: "a" * 1001)
      item.valid?
      expect(item.errors[:introduction]).to include("is too long (maximum is 1000 characters)")
    end

    it "価格が空では出品できない" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end

    it "価格が300円未満では出品できない" do
      item = build(:item, price: "299")
      item.valid?
      expect(item.errors[:price]).to include("must be greater than or equal to 300")
    end

    it "価格が10000000円以上は出品できない" do
      item = build(:item, price: "10000000")
      item.valid?
      expect(item.errors[:price]).to include("must be less than 10000000")
    end

    it "価格が数字でない場合(文字列の場合)は出品できない" do
      item = build(:item, price: "aaa")
      item.valid?
      expect(item.errors[:price]).to include("is not a number")
    end

    it "商品の状態が空では出品できない" do
      item = build(:item, condition_id: "")
      item.valid?
      expect(item.errors[:condition_id]).to include("can't be blank")
    end

    it "配送地域が空では出品できない" do
      item = build(:item, prefecture_id: "")
      item.valid?
      expect(item.errors[:prefecture_id]).to include("can't be blank")
    end

    it "発送までの日数が空では出品できない" do
      item = build(:item, day_id: "")
      item.valid?
      expect(item.errors[:day_id]).to include("can't be blank")
    end

    it "配送料の負担が空では出品できない" do
      item = build(:item, postage_id: "")
      item.valid?
      expect(item.errors[:postage_id]).to include("can't be blank")
    end

    it "配送方法が空では出品できない" do
      item = build(:item, way_id: "")
      item.valid?
      expect(item.errors[:way_id]).to include("can't be blank")
    end

    it "カテゴリーが空では出品できない" do
      item = build(:item, category_id: "")
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end


  end
end

