class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save!
      redirect_to root_path, notice: '出品完了しました'
    else
      redirect_to new_item_path,
      alert: '失敗しました'
    end
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :prefecture, :condition, :postage, :way, :day, :status, :category_id, :brand_id)
  end

end
