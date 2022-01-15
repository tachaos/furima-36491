class SellersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @seller_destination = SellerDestination.new
  end

  def create
    @seller_destination = SellerDestination.new(seller_params)
    if @seller_destination.valid?
      pay_item
      @seller_destination.save
      redirect_to root_path 
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || @item.seller.present?
  end

  def seller_params
    params.require(:seller_destination).permit(:postal_code, :delivery_source_id, :city, :block_number, :building_name, :phone_number, :seller_id).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: seller_params[:token],
      currency: 'jpy'
    )
  end

end
