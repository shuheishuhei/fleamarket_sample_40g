class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.item_images.build

    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end
  
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '出品完了しました'
    else
      redirect_to new_item_path,
      alert: '失敗しました'
    end
  end

  def edit
  end

  def update
    @item.update(item_params)
  end

  def destroy
    @item.destroy
  end
  
   def show
    @item = Item.find(params[:id])
  end

  #商品購入確認（仮）
  def purchase_comfirmation
  end
  
end

private

def item_params
  params.require(:item).permit(:name, :introduction, :price, :brand_id, :category_id, :sizing_id, :item_conditions_id, :postage_pay_id, :preparation_day_id, :prefecture_code, :buyer_id, :seller_id, item_images_attributes: [:id, :item_id, :image, :_destroy])
end

def set_item
  @item = Item.find(params[:id])
end
