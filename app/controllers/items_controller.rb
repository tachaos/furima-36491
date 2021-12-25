class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
  end

  private
  def item_params
    params.require(:item).permit(:name, :image, :description, :category_id, :status_id, :delivery_charge_id, :delivery_source_id, :delivery_days_id, :price).merge(user_id: current_user.id)
  end

end

