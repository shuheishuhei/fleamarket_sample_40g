require 'rails_helper'

describe Address do
  describe '#create_address' do
  #ウィザード形式3ページ目(必須事項が埋まっていない時にエラー表示をするか)
    it '全て入力されていたら登録できる' do
      address = build(:address)
      expect(address).to be_valid
    end

    it "名前(漢字)が空だと登録できない" do
      address = build(:address, destination_first_name: nil)
      address.valid?
      expect(address.errors[:destination_first_name]).to include("can't be blank", "is invalid")
    end

    it "名字(漢字)が空だと登録できない" do
      address = build(:address, destination_family_name: nil)
      address.valid?
      expect(address.errors[:destination_family_name]).to include("can't be blank", "is invalid")
    end

    it "名前(かな)が空だと登録できない" do
      address = build(:address, destination_first_name_kana: nil)
      address.valid?
      expect(address.errors[:destination_first_name_kana]).to include("can't be blank", "is invalid")
    end

    it "名字(かな)が空だと登録できない" do
      address = build(:address, destination_family_name_kana: nil)
      address.valid?
      expect(address.errors[:destination_family_name_kana]).to include("can't be blank", "is invalid")
    end

    it "郵便番号が入力されていないと進めない" do
      address = build(:address, post_code: nil)
      address.valid?
      expect(address.errors[:post_code]).to include("can't be blank")
    end

    it "都道府県が入力されていないと進めない" do
      address = build(:address, prefecture: nil)
      address.valid?
      expect(address.errors[:prefecture]).to include("can't be blank")
    end

    it "市区町村が入力されていないと進めない" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end

    it "番地が入力されていないと進めない" do
      address = build(:address, house_number: nil)
      address.valid?
      expect(address.errors[:house_number]).to include("can't be blank")
    end
  end
end