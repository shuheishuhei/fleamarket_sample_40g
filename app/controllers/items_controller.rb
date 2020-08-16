class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.item_images.build
  end

  def create
    @item = Item.new(item_params)
    @item.save
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path, notice: "削除しました"
    else
      render :new
    end
  end

  def destroy
    if @item.destroy
      redirect_to item_path, notice: "削除しました"
    else
      render :new
    end
  end
end

private

def item_params
  params.require(:item).permit(:name, :introduction, :price, :brand_id, :category_id, :sizing_id, :item_conditions_id, :postage_pay_id, :preparation_day_id, :prefecture_code, :buyer_id, :seller_id, item_images_attributes: [:id, :item_id, :image, :_destroy])
end

def set_item
  @item = Item.find(params[:id])
end
