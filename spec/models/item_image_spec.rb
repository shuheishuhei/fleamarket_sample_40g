require 'rails_helper'

describe ItemImage do
  describe "#create" do
<<<<<<< Updated upstream

    it "画像が1枚以上で出品できる" do
      item_image = build(:item_image)
      expect(item_image).to be_valid
    end

    it "画像が一枚以上ないと出品できない" do
=======
    
    it "商品画像があれば出品できる" do
      user = create(:user)
      item = create(:item)
      item_image = build(:item_image, item_id: item.id)
      expect(item_image).to be_valid
    end

    it "商品画像が空では出品できない" do
      user = create(:user)
      item = create(:item)
>>>>>>> Stashed changes
      item_image = build(:item_image, image: "")
      item_image.valid?
      expect(item_image.errors[:image]).to include("can't be blank")
    end

  end
end

