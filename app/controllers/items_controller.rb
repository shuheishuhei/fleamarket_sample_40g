class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
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

  def show
    @item = Item.find(params[:id])
  end

  #商品購入確認（仮）
  def purchase_comfirmation
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :prefecture, :condition, :postage, :way, :day, :status, :category_id, :brand_id)
  end
end

