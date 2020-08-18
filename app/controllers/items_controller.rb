class ItemsController < ApplicationController
  # before_action :set_item, except: [:index, :new, :create]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new

  
    

    @item.item_images.build

    @category_parent_array = []

    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent
    end
  end

  def get_category_children
    @category_children = Category.find_by(id: "#{params[:parent_id]}", ancestry: nil).children
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
  
  def show
    @item = Item.find(params[:id])
  end

  #商品購入確認（仮）
  def purchase_comfirmation
  end
  
end


  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :prefecture_id, :condition_id, :postage_id, :way_id, :day_id, :category_id, :brand, :status_id,item_images_attributes: [:id, :item_id, :image, :_destroy])
  end

end


# def set_item
#   @item = Item.find(params[:id])
# end

