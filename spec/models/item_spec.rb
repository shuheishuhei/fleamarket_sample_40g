require 'rails_helper'

describe Item do
  describe "create" do
    
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
      expect(item.errors[:name][0]).to include("is too long")
    end

    it "商品説明が空では出品できない" do
      item = build(:item, introduction: "")
      item.valid?
      expect(item.errors[:introduction]).to include("can't be blank")
    end

    it "商品説明が1000文字を超えている場合は登録できない" do
      item = build(:item, introduction: "a" * 1001)
      item.valid?
      expect(item.errors[:introduction]).to include("is too long")
    end

    it "価格が空では出品できない" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end

    it "価格が300円未満では出品できない" do
      item = build(:item, price: "299")
      item.valid?
      expect(item.errors[:price]).to include("greater_than_equal_or_equal_to %{count}")
    end

    it "価格が10000000円以上は出品できない" do
      item = build(:item, price: "10000000")
      item.valid?
      expect(item.errors[:price]).to include("less_than %{count}")
    end

    it "価格が数字でない場合(文字列の場合)は出品できない" do
      item = build(:item, price: "aaa")
      item.valid?
      expect(item.errors[:price]).to include("not a number")
    end

    it "商品の状態が空では出品できない" do
      item = build(:item, condition: "")
      item.valid?
      expect(item.errors[:condition]).to include("can't be blank")
    end

    it "配送地域が空では出品できない" do
      item = build(:item, prefecture: "")
      item.valid?
      expect(item.errors[:prefecture]).to include("can't be blank")
    end

    it "発送までの日数が空では出品できない" do
      item = build(:item, day: "")
      item.valid?
      expect(item.errors[:day]).to include("can't be blank")
    end

    it "配送料の負担が空では出品できない" do
      item = build(:item, postage: "")
      item.valid?
      expect(item.errors[:postage]).to include("can't be blank")
    end

    it "配送方法が空では出品できない" do
      item = build(:item, way: "")
      item.valid?
    expect(item.errors[:way]).to include("can't be blank")
    end

    it "カテゴリーが空では出品できない" do
      item = build(:item, category_id)
    end


  end
end