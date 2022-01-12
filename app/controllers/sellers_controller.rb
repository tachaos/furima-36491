class SellersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
    @seller_destination = SellerDestination.new
  end

  def create
    @item = Item.find(params[:item_id])
    @seller_destination = SellerDestination.new(seller_params)
    if @seller_destination.valid?
      @seller_destination.save
      redirect_to root_path 
    else
      render :index
    end
  end

  private

  def seller_params
    params.require(:seller_destination).permit(:postal_code, :delivery_source_id, :city, :block_number, :building_name, :phone_number).merge(user_id: current_user.id)
  end

end
