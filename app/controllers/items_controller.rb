class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item =Item.new(item_params)
    @item.save
  end

  def edit
  end

  def update
    @item.update(item_params)     
  end

  def destroy
  end
end

private

def item_params
  params.require(:item).permit(:name, :price, images_attributes: [:src, :_destroy, :id])
end

def set_item
  @item = Item.find(params[:id])
end
