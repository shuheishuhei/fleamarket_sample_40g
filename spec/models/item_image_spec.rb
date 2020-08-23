require 'rails_helper'

describe ItemImage do
  describe "#create" do

    it "画像が1枚以上で出品できる" do
      item_image = build(:item_image)
      expect(item_image).to be_valid
    end

    it "画像が一枚以上ないと出品できない" do
      item_image = build(:item_image, image: "")
      item_image.valid?
      expect(item_image.errors[:image]).to include("can't be blank")
    end

  end
end
